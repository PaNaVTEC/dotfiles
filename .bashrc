#!/bin/bash

[[ $- != *i* ]] && return
set -o vi

export XDG_CONFIG_HOME=$HOME/.config
export BROWSER=inox
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export DOTFILES_LOCATION=~/dotfiles

source "$DOTFILES_LOCATION/programming/index.sh"
source "$DOTFILES_LOCATION/finance/index.sh"
source "$DOTFILES_LOCATION/system/index.sh"
source "$DOTFILES_LOCATION/paths.sh"
source ~/.env.sh

if [[ $(uname) == "Linux" ]]; then
  setxkbmap -layout us -variant altgr-intl -option nodeadkeys
  eval $(dircolors ~/.dircolors)
fi
