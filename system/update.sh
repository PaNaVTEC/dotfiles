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
alias updateMirrors='sudo reflector --sort rate -l 10 -f 5 --save /etc/pacman.d/mirrorlist && yaourt -Syy'

commitsBehind () {
  git fetch
  git rev-list \
    --left-right \
    --count master...origin/master | awk '{print $2}'
}

vimUpdate () {
  echo "Upgrading vim plugins"
  vim +PlugClean +PlugUpgrade +PlugUpdate +qa
}

systemUpdate () {
  echo "Updating dotfiles"
  (cd "$DOTFILES_LOCATION" && git pull)

  echo "Installing new inox extensions"
  sudo maninex -i | grep --invert-match "is already installed"
  echo "Done"

  echo "Updating inox extensions"
  sudo maninex -u | grep --invert-match "up-to-date"
  echo "Done"

  echo "Upgrading global Js packages"
  sudo yarn global upgrade

  echo "Upgrade yarn completion package"
  sudo curl -o "/usr/local/bin/yarn-completion.bash" https://raw.githubusercontent.com/dsifford/yarn-completion/master/yarn-completion.bash
  sudo curl -o "/usr/local/bin/git-completion.bash" https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash

  echo "Updating VIM"
  vimUpdate;

  echo "Updating prompt"
  (
    cd "$HOME/.powerline-hs/"
    if [ "$(commitsBehind)" -gt 1 ]; then
      git pull
      stack install
    fi
  )

  "Regenerating shortcuts"
  shortcuts

  echo "Upgrading system packages"
  yaourt -Syua "$1"
}

orphans() {
  yaourt -Qdt
}

cleanCache() {
  yaourt -Sc
}
