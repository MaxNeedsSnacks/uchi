# systemwide settings for different device classes

# the classes are currently only valid for either macos or linux because i'm...
# well, too lazy to add a bunch of no-ops atm, but dw i'll get to it(tm)

[macos]
class-laptop: base firewall-on

[macos]
class-server: base firewall-off remote-login no-sleep

[linux]
class-desktop: base

[macos]
base: timezone login-shell pam-touchid darwin-defaults

[linux]
base: timezone login-shell

[macos]
timezone:
    sudo systemsetup -settimezone "Europe/Berlin"

[linux]
timezone:
    sudo timedatectl set-timezone Europe/Berlin

# sets login shell for the current user to fish
login-shell:
    #!/bin/sh
    fish=$(which fish)
    grep -qx "$fish" /etc/shells || echo "$fish" | sudo tee -a /etc/shells
    [ "$SHELL" = "$fish" ] || chsh -s "$fish"

# touch id / apple watch auth for sudo (pam_tid covers both)
[macos]
pam-touchid:
    #!/bin/sh
    sudo tee /etc/pam.d/sudo_local >/dev/null <<'EOF'
    auth       optional       /opt/homebrew/lib/pam/pam_reattach.so
    auth       sufficient     pam_tid.so
    EOF

# macOS user preferences (from my old ky/darwin/preferences.nix)
[macos]
darwin-defaults:
    #!/bin/sh
    set -eu

    # keyboard & text input
    defaults write -g ApplePressAndHoldEnabled -bool false # disable accent panels from holding keys
    # and no autocorrect or any of that funny business either
    defaults write -g NSAutomaticCapitalizationEnabled -bool false
    defaults write -g NSAutomaticPeriodSubstitutionEnabled -bool false
    defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool false
    defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false

    # panels & extensions
    defaults write -g AppleShowAllExtensions -bool true
    defaults write -g NSNavPanelExpandedStateForSaveMode -bool true
    defaults write -g NSNavPanelExpandedStateForSaveMode2 -bool true
    defaults write -g WebKitDeveloperExtras -bool true

    # dock (hot corners: 1 = disabled)
    defaults write com.apple.dock autohide -bool false
    defaults write com.apple.dock wvous-tl-corner -int 1
    defaults write com.apple.dock wvous-tr-corner -int 1
    defaults write com.apple.dock wvous-bl-corner -int 1
    defaults write com.apple.dock wvous-br-corner -int 1

    # finder
    defaults write com.apple.finder ShowStatusBar -bool true
    defaults write com.apple.finder ShowPathbar -bool true
    defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
    defaults write com.apple.finder FXPreferredViewStyle -string "icnv"
    defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
    defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
    defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
    defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
    defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
    defaults write com.apple.finder _FXSortFoldersFirst -bool true

    # trackpad (both plists, like nix-darwin did)
    for domain in com.apple.AppleMultitouchTrackpad com.apple.driver.AppleBluetoothMultitouch.trackpad; do
        defaults write "$domain" Clicking -bool true
        defaults write "$domain" TrackpadRightClick -bool true
        defaults write "$domain" TrackpadThreeFingerDrag -bool false
    done

    # misc
    defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
    defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
    defaults write com.apple.AdLib allowApplePersonalizedAdvertising -bool false

    # pinentry-touchid expects these (was ky/darwin/pinentry-touchid.nix)
    defaults write org.gpgtools.common DisableKeychain -bool true
    defaults write org.gpgtools.common UseKeychain -bool false

    killall Dock Finder 2>/dev/null || true

[macos]
remote-login:
    sudo systemsetup -setremotelogin on

[macos]
no-sleep:
    sudo pmset -a sleep 0

[macos]
firewall-on:
    #!/bin/sh
    fw=/usr/libexec/ApplicationFirewall/socketfilterfw
    sudo "$fw" --setglobalstate on
    sudo "$fw" --setallowsigned on
    sudo "$fw" --setallowsignedapp on
    sudo "$fw" --setstealthmode on

[macos]
firewall-off:
    sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate off

# no linux stack for firewall because meh

# alllll the hostname declarations! (macos especially is finnicky
# about this when duplicate hostnames exist, so we have a recipe for it)
[macos]
hostname name:
    sudo scutil --set ComputerName {{ name }}
    sudo scutil --set HostName {{ name }}
    sudo scutil --set LocalHostName {{ name }}

[linux]
hostname name:
    sudo hostnamectl set-hostname {{ name }}
