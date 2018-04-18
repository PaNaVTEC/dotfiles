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

export PROMPT_DIRTRIM=2
powerline-daemon -q
POWERLINE_COMMAND=$HOME/.local/bin/powerline-hs
POWERLINE_CONFIG_COMMAND=/bin/true
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. /usr/lib/python3.6/site-packages/powerline/bindings/bash/powerline.sh

if [[ $(uname) == "Linux" ]]; then
  setxkbmap -layout us -variant altgr-intl -option nodeadkeys
  eval $(dircolors ~/.dircolors)
fi
