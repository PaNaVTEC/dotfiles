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
  local commitsBehind
  commitsBehind=$(git rev-list \
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

  echo "Update inox extensions"
  sudo maninex -i # Installs new extensions
  sudo maninex -u # Upgrade already installed extensions

  echo "Upgrading global Js packages"
  sudo yarn global upgrade

  echo "Upgrade yarn completion package"
  curl -o "$DOTFILES_LOCATION/programming/yarn-completion.bash" https://raw.githubusercontent.com/dsifford/yarn-completion/master/yarn-completion.bash
  curl -o "$DOTFILES_LOCATION/programming/git-completion.bash" https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash

  vimUpdate;

  echo "Upgrading system packages"
  yaourt -Syua "$1"
}

orphans() {
  yaourt -Qdt
}
