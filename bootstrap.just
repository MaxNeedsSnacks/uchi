# single-use installers

[macos]
all: brew bootstrap-pkgs rosetta

[linux]
all: bootstrap-pkgs paru

[macos]
brew:
    #!/bin/sh
    if [ ! -x /opt/homebrew/bin/brew ]; then
        NONINTERACTIVE=1 /bin/bash -c \
            "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

[macos]
rosetta:
    softwareupdate --install-rosetta --agree-to-license

[linux]
bootstrap-pkgs:
    #!/bin/sh
    sudo pacman -S --needed --noconfirm base-devel git coreutils fish chezmoi just

[macos]
bootstrap-pkgs:
    #!/bin/sh
    command -v brew >/dev/null || eval "$(/opt/homebrew/bin/brew shellenv)"
    brew install --no-ask just chezmoi

[linux]
paru:
    #!/bin/sh
    command -v paru >/dev/null && exit 0
    sudo pacman -S --needed --noconfirm base-devel git
    tmp=$(mktemp -d)
    git clone https://aur.archlinux.org/paru-bin.git "$tmp/paru-bin"
    cd "$tmp/paru-bin" && makepkg -si --noconfirm
