#!/usr/bin/env bash
set -o vi

export XDG_CONFIG_HOME=$HOME/.config
export BROWSER=firefox
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export DOTFILES_LOCATION=$HOME/dotfiles
export SITE_PACKAGES=$(python -c 'import site; print(site.getsitepackages()[0])')
export DISTRO=$(awk -F "=" '/^ID=/ {print $2}' /etc/*-release)

source "$HOME/.env.sh"
source "$DOTFILES_LOCATION/programming/index.sh"
source "$DOTFILES_LOCATION/finance/index.sh"
source "$DOTFILES_LOCATION/system/index.sh"
source "$DOTFILES_LOCATION/system/paths.sh"
source "$DOTFILES_LOCATION/system/prompt.sh"
[ -f "$HOME/.bash_shortcuts" ] && source "$HOME/.bash_shortcuts"

if [[ $(uname) == "Linux" ]]; then
  setxkbmap -layout us -variant altgr-intl -option nodeadkeys
  eval $(dircolors ~/.dircolors)
fi
