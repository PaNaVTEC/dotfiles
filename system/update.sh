#!/usr/bin/env bash

if [[ $DISTRO == "ubuntu" ]]; then
  alias ys='apt-cache search'
  alias yi='sudo apt-get install'
  alias yin='sudo apt-get install -y'
  alias yr='sudo apt-get remove'
  alias yu='sudo apt-get upgrade'
  alias yun='sudo apt-get upgrade -y'
elif [[ $DISTRO == "nixos" ]]; then
  alias ys='nix-env -qaP'
  alias yi='sudo nix-env -i'
  alias yr='sudo nix-env --uninstall'
  alias yu='yun'
  alias yun="sudo nix-channel --update && sudo nix-env -u '*'"

  # Update single package to latest version in an impure env
  nixUpdatePackage () {
     sudo nix-channel --update nixpkgs
     sudo nix-env -u "$1" # where #1 is the name of the package
     sudo nixos-rebuild switch --upgrade
  }

  nixPathOfPackage () {
    nix-store -q --requisites /run/current-system ~/.nix-profile | grep "$1"
  }

  nixUpdateVscodeExtensions () {
    $DOTFILES_LOCATION/nixos/updateVscodeExtensions.sh "$DOTFILES_LOCATION/nixos/vscode-extensions" > "$DOTFILES_LOCATION/nixos/vscode-extensions.nix"
  }

else
  alias y='yay'
  alias ys='yay -Ss'
  alias yi='yay -S'
  alias yin='yi --noconfirm'
  alias yunf='yu --noconfirm --force'
  alias yr='yay -R'
  alias yu='systemUpdate;'
  alias yun='systemUpdate "--noconfirm";'
  alias updateMirrors='sudo reflector --sort rate -l 10 -f 5 --save /etc/pacman.d/mirrorlist && yay -Syy'
fi

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

  echo "Upgrading global Js packages"
  sudo yarn global upgrade

  echo "Updating tmux plugins"
  $HOME/.tmux/plugins/tpm/bin/update_plugins all

  echo "Upgrade yarn completion package"
  sudo curl -o "/usr/local/bin/yarn-completion.bash" https://raw.githubusercontent.com/dsifford/yarn-completion/master/yarn-completion.bash
  sudo curl -o "/usr/local/bin/git-completion.bash" https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash

  "Regenerating shortcuts"
  shortcuts

  echo "Upgrading system packages"
  yay -Syu "$1"
}

orphans() {
  yay -Yc
}
