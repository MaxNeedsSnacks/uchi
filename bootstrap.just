[macos]
all: timezone pam-touchid login-shell rosetta

[linux]
all: timezone login-shell

[group("all")]
[macos]
timezone:
    sudo systemsetup -settimezone "Europe/Berlin"

[group("all")]
[linux]
timezone:
    timedatectl set-timezone Europe/Berlin

# sets login shell for the current user to fish
[group("all")]
login-shell:
    #!/bin/sh
    fish=$(which fish)
    grep -qx "$fish" /etc/shells || echo "$fish" | sudo tee -a /etc/shells
    [ "$SHELL" = "$fish" ] || chsh -s "$fish"

[group("all")]
[macos]
pam-touchid:
    #!/bin/sh
    sudo tee /etc/pam.d/sudo_local >/dev/null <<'EOF'
    auth       optional       /opt/homebrew/lib/pam/pam_reattach.so
    auth       sufficient     pam_tid.so
    EOF

[group("all")]
[macos]
rosetta:
    softwareupdate --install-rosetta --agree-to-license

# enables remote access via ssh and disables auto sleep for the machine
[macos]
darwin-server-settings:
    sudo systemsetup -setremotelogin on
    sudo pmset -a sleep 0
