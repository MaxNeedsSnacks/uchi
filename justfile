# machine setup lives in modules: bootstrap:: installs things (once),
# system:: configures things; `just setup <class>` runs both

mod bootstrap
mod system

default:
    @just --list --list-submodules

# full setup for a machine class: laptop, server (macos) or desktop (linux)
setup class="":
    just bootstrap::all
    chezmoi apply
    @if [ -n "{{ class }}" ]; then just system::class-{{ class }}; fi

# diffs installed brews and casks vs what we have in Brewfile
# just in case i want to make some things i install more... permanent
[macos]
brew-drift:
    #!/bin/bash
    comm -13 \
      <(grep -ohE '^(brew|cask) "[^"]+"' ~/.config/homebrew/Brewfile | sort) \
      <({ brew leaves | sed 's/.*/brew "&"/'; brew list --cask | sed 's/.*/cask "&"/'; } | sort)

# same idea for arch: explicitly installed packages not in the pkglist
[linux]
pacman-drift:
    #!/bin/bash
    comm -13 \
      <(grep -vE '^\s*(#|$)' ~/.config/paru/pkglist.txt | sort) \
      <(pacman -Qqe | sort)
