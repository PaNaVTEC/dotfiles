#!/bin/bash -e

alias y='yaourt'
alias ys='yaourt -Ss'
alias yi='yaourt -S'
alias yin='yi --noconfirm'
alias yunf='yu --noconfirm --force'
alias yp='yaourt -Qm'
alias yr='yaourt -R'
alias yu='systemUpdate;'
alias yun='systemUpdate "--noconfirm";'
vimUpdate () {
  echo "Upgrade VIM"
  (source "$DOTFILES_LOCATION/setup/setup.sh" && compileVim;)

  echo "Upgrading vim plugins"
  vim +PlugClean +PlugUpgrade +PlugUpdate +qa
}

systemUpdate () {
  echo "Updating dotfiles"
  (cd "$DOTFILES_LOCATION" && git pull)

  echo "Upgrading global Js packages"
  sudo yarn global upgrade

  vimUpdate;

  echo "Upgrading system packages"
  yaourt -Syua "$1"
}
