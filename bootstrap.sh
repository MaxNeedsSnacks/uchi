#!/bin/sh

# bootstrap my dotfiles: get standalone just + chezmoi (standalone binaries into a
# tempdir), clone the repo, then forward to just for setup.
#
# usage: sh -c "$(curl -fsSL https://dots.someone.ky/bootstrap)" -- [class]
# (sh -c form matters: apply prompts for the age passphrase on stdin)
set -eu

repo="${CHEZMOI_REPO:-https://github.com/MaxNeedsSnacks/uchi.git}"
class="${1:-}"

tmp="$(mktemp -d)"
export PATH="$tmp:$PATH"

command -v just >/dev/null 2>&1 ||
    curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh |
    bash -s -- --to "$tmp"

command -v chezmoi >/dev/null 2>&1 ||
    sh -c "$(curl -fsSL get.chezmoi.io)" -- -b "$tmp"

src="$HOME/.local/share/chezmoi"
[ -d "$src/.git" ] || chezmoi init "$repo"

echo "setting up system with class ${class:-"none"}..."

just --justfile "$src/justfile" setup "$class"
echo "all done! don't forget to run just system::hostname <name> and sign in with app stores / cred helpers as necessary"
