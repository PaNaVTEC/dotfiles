#!/usr/bin/env bash

set -e

NIX_SHELL_PATH=~/dotfiles/nixos/shells
selectedShell=$(echo -e "$(ls $NIX_SHELL_PATH)" | dmenu)
nix-shell "$NIX_SHELL_PATH/$selectedShell" --run "$1"
