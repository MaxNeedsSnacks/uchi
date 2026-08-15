# machine setup lives in modules: `just bootstrap::all` after
# `chezmoi init --apply`; `just system::…` for other systemwide settings

mod bootstrap
mod system

default:
    @just --list --list-submodules

# quick setup for a new machine
setup:
    just bootstrap::all

# diffs installed brews and casks vs what we have in Brewfile
# just in case i want to make some things i install more... permanent
[macos]
brew-drift:
    #!/bin/bash
    comm -13 \
      <(grep -ohE '^(brew|cask) "[^"]+"' ~/.config/homebrew/Brewfile | sort) \
      <({ brew leaves | sed 's/.*/brew "&"/'; brew list --cask | sed 's/.*/cask "&"/'; } | sort)
