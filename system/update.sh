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
  (
  cd ~/vim
  git fetch
  local commitsBehind=$(git rev-list \
    --left-right \
    --count master...origin/master | awk '{print $2}')
  if [ "$commitsBehind" -gt 50 ]; then
    (source "$DOTFILES_LOCATION/setup/setup.sh" && compileVim;)
  fi
  )
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

orphans() {
  if [[ ! -n $(pacman -Qdt) ]]; then
    echo "No orphans to remove."
  else
    sudo pacman -Rns "$(pacman -Qdtq)"
  fi
}
