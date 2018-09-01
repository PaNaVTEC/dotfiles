#!/usr/bin/env bash

export PROMPT_DIRTRIM=2

function _update_ps1() {
  PS1="$(powerline-go -cwd-mode plain -modules venv,ssh,cwd,perms,git,docker,jobs,exit,root -error $?)"
}

if [ "$TERM" != "linux" ]; then
  PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi
