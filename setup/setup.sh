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
  yaourt --noconfirm -S ./yaourt_i3.txt

  # Default thunar to file directories
  #gvfs-mime --set inode/directory thunar.desktop
  #xdg-mime default thunar.desktop inode/directory
  # Window switcher
  sudo pip install i3-py quickswitch-i3

  ln -sfn ${dir}/config/i3 ${HOME}/.config/i3
  
  # gsimplecal configuration
  [ -d ${HOME}/.config/gsimplecal ] || mkdir -p ${HOME}/.config/gsimplecal
  ln -sfn ${dir}/config/gsimplecal/config ${HOME}/.config/gsimplecal/config

  #py3status
  sudo pip install py3status
  ln -sfn ${dir}/config/i3status/i3status.conf ${HOME}/.i3/i3status.conf
  sudo cp ${dir}/config/i3status/xrandr.py /usr/lib/python3.6/site-packages/py3status/modules
  sudo cp ${dir}/config/i3status/pomodoro.py /usr/lib/python3.6/site-packages/py3status/modules	
  [ -e /etc/i3status.conf ] && sudo rm /etc/i3status.conf
}

installFonts() {
  echo "Installing fonts"
  sleep 2
  yaourt --noconfirm -S ./yaourt_fonts.txt 
}

installThemes() {
  echo "Installing themes"
  sleep 2
  yaourt --noconfirm -S ./yaourt_themes.txt
}

installJava() {
  echo "Installing Java"
  sleep 2 
}

installGit() {
  yaourt --noconfirm -S ./yaourt_git.txt
  ln -sfn ${dir}/.gitconfig ${HOME}/.gitconfig
  gibo Vim JetBrains Tags Vagrant Windows macOS Linux Archives >> ~/.gitignore.global
}

installDevTools() {
  echo "Installing developer tools"
  sleep 2

  installGit;
  yaourt --noconfirm -S ./yaourt_java.txt
  yaourt --noconfirm -S ./yaourt_android.txt
  yaourt --noconfirm -S ./yaourt_scala.txt
  yaourt --noconfirm -S ./yaourt_clojure.txt

  yaourt --noconfirm -S ./yaourt_devtools.txt

  #IntelliJ watches in the FS
  sudo bash -c 'echo "fs.inotify.max_user_watches = 524288" > /etc/sysctl.d/99-sysctl.conf'
  sudo sysctl --system
}

installTools() {
  echo "Installing apps and tools"
  sleep 2
  yaourt --noconfirm -S ./yaourt_tools.txt
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

installVim() {
  yaourt -S --noconfirm vim silver-searcher-git vim-ensime-git
  #Install plugin system 
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  #Configuration	  
  ln -sfn ${dir}/.vimrc ${HOME}/.vimrc
  #ensime scala needed dependencies
  # sudo pip install websocket-client sexpdata
  echo "Open vim and run :PlugInstall to complete plugin installation"
}

installRanger() { 
  yaourt -S ranger --noconfirm
  ranger --copy-config=scope
  ln -sfn ${dir}/config/ranger/config ${HOME}/.config/ranger/rc.conf
}

installKhal() { 
  sudo pip install khal vdirsyncer requests-oauthlib

  [ -d ${HOME}/.config/khal ] || mkdir -p ${HOME}/.config/khal
  [ -d ${HOME}/.config/vdirsyncer ] || mkdir -p ${HOME}/.config/vdirsyncer

  ln -sfn ${dir}/config/khal/khal.conf ${HOME}/.config/khal/khal.conf
  cp ${dir}/config/khal/vdirsyncerconfig ${HOME}/.config/vdirsyncer/config
}

installAudio() { 
  yaourt -S --noconfirm ./yaourt_audio.txt
}

installCompton() {
  yaourt -S --noconfirm \
    compton \
    xorg-xwininfo
  mkdir ~/.before_startx
  echo "compton -c -i 0.9 -b &" >> ~/.before_startx/run.sh	
  chmod a+x ~/.before_startx/run.sh
  ln -sfn ${dir}/config/compton/compton.conf ${HOME}/.config/compton.conf
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
[ -d ${HOME}/.i3 ] || mkdir ${HOME}/.i3

#Makes binary executable
chmod a+x ${dir}/bin/*

#TODO: this autommagically
echo "Remember that you need to uncommed the [multilib] repo in /etc/pacman.conf, if you haven't done that, please modify that file, update with pacman -Syua and come back later"
echo "actionSystem.suspendFocusTransferIfApplicationInactive=false add this into intelliJ to prevent focus lose"

ask "install yaourt?" Y && installYaourt;
ask "install i3?" Y && installi3;
ask "install compton?" Y && installCompton;
ask "install fonts?" Y && installFonts;
ask "install dev tools?" Y && installDevTools;
ask "install apps and tools?" Y && installTools;
ask "install themes?" Y && installThemes;
ask "install vim config?" Y && installVim;
ask "install audio?" Y && installAudio;

ask "Install redshift + config?" Y && installRedshift
ask "Install symlink for .xinitrc?" Y && ln -sfn ${dir}/.xinitrc ${HOME}/.xinitrc
ask "Install symlink for .bashrc?" Y && ln -sfn ${dir}/.bashrc ${HOME}/.bashrc
ask "Install symlink for .bash_profile?" Y && ln -sfn ${dir}/.bash_profile ${HOME}/.bash_profile

ask "Install configuration for bin?" Y && ln -sfn ${dir}/bin ${HOME}/.bin
ask "Install configuration for dunst?" Y && ln -sfn ${dir}/config/dunst ${HOME}/.config/dunst
ask "Install configuration for termite?" Y && ln -sfn ${dir}/config/termite ${HOME}/.config/termite && ln -sfn ${dir}/.dircolors ${HOME}/.dircolors;
ask "Install screensavers?" Y && installScreensavers;
ask "Install bluetooth resume patch?" Y && installBluetoothResumePatch; 
ask "Install Ranger" Y && installRanger; 
ask "Install Khal" Y && installKhal;
