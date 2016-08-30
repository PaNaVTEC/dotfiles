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
    xorg-server \
    xorg-xinit \
    xorg-xinput \
    xorg-xprop \
    i3 \
    j4-dmenu-desktop \
    py3status \
    py3status-modules \
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
    thunar \
    thunar-volman \
    thunar-archive-plugin \
    thunar-dropbox \
    termite \
    dunst \
    acpi \
    iw
    # Default thunar to file directories
    #gvfs-mime --set inode/directory thunar.desktop
    #xdg-mime default thunar.desktop inode/directory
    # Window switcher
    sudo pip install i3-py
    sudo pip install quickswitch-i3
    #for spotify py3 module
    sudo pip install dbus-python
    sleep 2
    yaourt -S i3lock-blur --noconfirm
  }

installFonts() {
  echo "Installing fonts"
  sleep 2
  yaourt --noconfirm -S \
      ttf-font-awesome \
      ttf-google-fonts-git \
      ttf-ms-fonts \
      ttf-droid-sans-mono-dotted-powerline-git
}

installThemes() {
  echo "Installing themes"
  sleep 2
  yaourt --noconfirm -S \
      paper-gtk-theme-git \
      paper-icon-theme-git \
      numix-icon-theme-git \
      gtk-theme-arc \
      gtk-theme-arc-grey-git \
      gtk-theme-solarc-git \
      lxappearance
}

installDevTools() {
  echo "Installing developer tools"
  sleep 2
  yaourt --noconfirm -S \
      jdk \
      jdk7 \
      jd-gui-bin \
      scala \
      sbt \
      android-file-transfer \
      android-studio \
      android-apktool \
      android-sdk-build-tools \
      intellij-idea-community-edition \
      dex2jar \
      visual-studio-code \
      virtualbox \
      linux-headers \
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
      archey3 \
      franz \
      keeweb-desktop
}

installRedshift() {
  echo "Installing redshift"
  sleep 2
  yaourt --noconfirm -S redshift
  [ -d ${HOME}/.config/redshift ] || mkdir -p ${HOME}/.config/redshift
  ln -sfn ${dir}/config/redshift/config ${HOME}/.config/redshift/config
}

installScreensavers() {
  echo "Installing screensavers"
  sleep 2
  yaourt --noconfirm -S nyancat
}

installBluetoothResumePatch() {
  echo "Installing resume patch"
  sleep 2
  sudo cat 'ACTION=="add", KERNEL=="hci0", RUN+="/usr/bin/hciconfig hci0 up"' >> /etc/udev/rules.d/10-local.rules
}

installYaourt() {
  sudo pacman -S --needed base-devel git wget yajl
  wget https://aur.archlinux.org/cgit/aur.git/snapshot/package-query.tar.gz
  tar xvfz package-query.tar.gz
  cd package-query
  makepkg -si
  cd ..
  rm -rf package-query
  rm package-query.tar.gz
  wget https://aur.archlinux.org/cgit/aur.git/snapshot/yaourt.tar.gz
  tar xvfz yaourt.tar.gz
  cd yaourt
  makepkg -si
  cd ..
  rm -rf yaourt
  rm yaourt.tar.gz
  #init keyring
  sudo pacman-key --init 
  sudo pacman-key --populate archlinux
}

dir=`pwd`
if [ ! -e "${dir}/${0}" ]; then
  echo "Script not called from within repository directory. Aborting."
  exit 2
fi
dir="${dir}/.."

echo "PaNaVTEC dotfiles installer"
# Makes dir for scrot screenshots
[ -d ${HOME}/Pictures/Screenshots ] || mkdir -p ${HOME}/Pictures/Screenshots
[ -d ${HOME}/.data ] || mkdir ${HOME}/.data

#Makes binary executable
chmod a+x ${dir}/bin/*

#TODO: this autommagically
echo "Remember that you need to uncommed the [multilib] repo in /etc/pacman.conf, if you haven't done that, please modify that file, update with pacman -Syua and come back later"

ask "install yaourt?" Y && installYaourt
ask "install i3?" Y && installi3
ask "install fonts?" Y && installFonts
ask "install dev tools?" Y && installDevTools
ask "install apps and tools?" Y && installTools
ask "install themes?" Y && installThemes

ask "Install redshift + config?" Y && installRedshift
ask "Install symlink for .xinitrc?" Y && ln -sfn ${dir}/.xinitrc ${HOME}/.xinitrc
ask "Install symlink for .bashrc?" Y && ln -sfn ${dir}/.bashrc ${HOME}/.bashrc
ask "Install symlink for .bash_profile?" Y && ln -sfn ${dir}/.bash_profile ${HOME}/.bash_profile

ask "Install configuration for bin?" Y && ln -sfn ${dir}/bin ${HOME}/.bin
ask "Install configuration for i3?" Y && ln -sfn ${dir}/config/i3 ${HOME}/.config/i3
ask "Install configuration for i3status/py3status?" Y && ln -sfn ${dir}/config/i3status/i3status.conf ${HOME}/.i3/i3status.conf && sudo rm /etc/i3status.conf
ask "Install configuration for dunst?" Y && ln -sfn ${dir}/config/dunst ${HOME}/.config/dunst
ask "Install configuration for termite?" Y && ln -sfn ${dir}/config/termite ${HOME}/.config/termite && ln -sfn ${dir}/.dircolors ${HOME}/.dircolors;
ask "Install screensavers?" Y && installScreensavers;
ask "Install bluetooth resume patch?" Y && installBluetoothResumePatch;