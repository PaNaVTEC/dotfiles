#!/usr/bin/env bash
set -e

ask() {
  # http://djm.me/ask
  while true; do

    if [ "${2:-}" = "Y" ]; then
      prompt="Y/n"
      default=Y
    elif [ "${2:-}" = "N" ]; then
      prompt="y/N"
      default=N
    else
      prompt="y/n"
      default=
    fi

    # ask the question
    read -p "$1 [$prompt] " REPLY

    # default?
    if [ -z "$REPLY" ]; then
       REPLY=$default
    fi

    # check if the reply is valid
    case "$REPLY" in
      Y*|y*) return 0 ;;
      N*|n*) return 1 ;;
    esac

  done
}

installi3() {
  echo "Installing i3 and required tools"
  sleep 2
  yaourt --noconfirm -S \
    i3 \
    j4-dmenu-desktop \
    i3blocks \
    i3lock-blur \
    xtitle \
    xdotool \
    feh \
    unclutter \
    scrot \
    htop \
    python-pip \
    gsimplecal \
    xorg-xbacklight \
    jshon \
    caja
    # Default caja to file directories
    gvfs-mime --set inode/directory caja.desktop
    xdg-mime default caja.desktop inode/directory
    # Window switcher
    sudo pip install i3-py
    sudo pip install quickswitch-i3
}

installFonts() {
  echo "Installing fonts"
  sleep 2
  yaourt --noconfirm -S \
      ttf-font-awesome \
      ttf-google-fonts-git \
      ttf-ms-fonts
}

installThemes() {
  echo "Installing themes"
  sleep 2
  yaourt --noconfirm -S \
      paper-gtk-theme-git \
      paper-icon-theme-git \
      numix-icon-theme-git \
      lxapparence
}

installDevTools() {
  echo "Installing developer tools"
  sleep 2
  yaourt --noconfirm -S \
      jdk \
      jdk7 \
      jd-gui-bin \
      android-file-transfer \
      android-studio \
      diffmerge \
      sublime-text \
      genymotion \
      gitflow-git \
      smartgit
}

installTools() {
  echo "Installing apps and tools"
  sleep 2
  yaourt --noconfirm -S \
      firefox \
      dropbox \
      google-chrome \
      google-talkplugin \
      spotify \
      archey3
}

installRedshift() {
  echo "Installing redshift"
  sleep 2
  yaourt --noconfirm -S redshift
}

installScreensavers() {
  echo "Installing screensavers"
  sleep 2
  yaourt --noconfirm -S nyancat
}

installBluetoothResumePatch() {
  echo "Installing resume patch"
  sleep 2
  sudo cat 'ACTION=="add", KERNEL=="hci0", RUN+="/usr/bin/hciconfig hci0 up"' >> 
/etc/udev/rules.d/10-local.rules
}

dir=`pwd`
if [ ! -e "${dir}/${0}" ]; then
  echo "Script not called from within repository directory. Aborting."
  exit 2
fi
dir="${dir}/.."

echo "PaNaVTEC dotfiles installer"
# Makes dir for scrot screenshots
mkdir ${HOME}/Pictures/Screenshots
mkdir ${HOME}/.data

#Makes binary executable
chmod a+x ${dir}/bin/*

ask "install i3?" Y && installi3
ask "install fonts?" Y && installFonts
ask "install dev tools?" Y && installDevTools
ask "install apps and tools?" Y && installTools
ask "install themes?" Y && installThemes

ask "Install redshift + config?" Y && installRedshift; mkdir ${HOME}/.config/redshift; ln -sfn ${dir}/config/redshift/config ${HOME}/.config/redshift/config
ask "Install symlink for .xinitrc?" Y && ln -sfn ${dir}/.xinitrc ${HOME}/.xinitrc
ask "Install symlink for .bashrc?" Y && ln -sfn ${dir}/.bashrc ${HOME}/.bashrc
ask "Install symlink for .bash_profile?" Y && ln -sfn ${dir}/.bash_profile ${HOME}/.bash_profile

ask "Install configuration for bin?" Y && ln -sfn ${dir}/bin ${HOME}/.bin
ask "Install configuration for i3?" Y && ln -sfn ${dir}/config/i3 ${HOME}/.config/i3
ask "Install configuration for i3blocks?" Y && ln -sfn ${dir}/.i3blocks.conf ${HOME}/.i3blocks.conf; mkdir ${HOME}/.config/i3blocks; ln -sfn ${dir}/config/i3blocks ${HOME}/.config/i3blocks
ask "Install configuration for dunst?" Y && mkdir ${HOME}/.config/dunst; ln -sfn ${dir}/config/dunst ${HOME}/.config/dunst
ask "Install configuration for termite?" Y && mkdir ${HOME}/.config/termite; ln -sfn ${dir}/config/termite ${HOME}/.config/termite; ln -sfn ${dir}/.dircolors ${HOME}/.dircolors;
ask "Install screensavers?" Y && installScreensavers;
ask "Install bluetooth resume patch?" Y && installBluetoothResumePatch;
