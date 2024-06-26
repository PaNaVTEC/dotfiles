#!/usr/bin/env bash
set -o vi

export XDG_CONFIG_HOME=$HOME/.config
export LC_TIME=es_ES.utf8
#export BROWSER=brave
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export DOTFILES_LOCATION=$HOME/dotfiles
export DISTRO=$(awk -F "=" '/^ID=/ {print $2}' /etc/*-release | sed 's/^"\(.*\)"$/\1/')

[ -f "$HOME/.env.sh" ] && source "$HOME/.env.sh"
source "$DOTFILES_LOCATION/programming/index.sh"
source "$DOTFILES_LOCATION/system/index.sh"
source "$DOTFILES_LOCATION/system/paths.sh"
source "$DOTFILES_LOCATION/system/prompt.sh"
[ -f "$HOME/.bash_shortcuts" ] && source "$HOME/.bash_shortcuts"

if [[ $(uname) == "Linux" ]]; then
  setxkbmap -layout us -variant altgr-intl -option nodeadkeys
  eval $(dircolors ~/.dircolors)
fi

eval "$(direnv hook bash)"
