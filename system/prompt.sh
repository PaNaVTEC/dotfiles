#!/usr/bin/env bash

export PROMPT_DIRTRIM=2

function _update_ps1() {
  PS1="$(powerline-go -cwd-mode plain -modules venv,ssh,cwd,perms,git,nix-shell,docker,jobs,exit,root -error $?)"
}

# Workaround for nix-shell --pure
if [ "$IN_NIX_SHELL" == "pure" ]; then
  if [ -x "$HOME/.nix-profile/bin/powerline-go" ]; then
    alias powerline-go="$HOME/.nix-profile/bin/powerline-go"
  elif [ -x "/run/current-system/sw/bin/powerline-go" ]; then
    alias powerline-go="/run/current-system/sw/bin/powerline-go"
  fi
fi

if [ "$TERM" != "linux" ]; then
  PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
  PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi
