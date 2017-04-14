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

  ln -sfn ${dir}/config/i3 ${HOME}/.config/i3
  
  # gsimplecal configuration
  mkdir -p ${HOME}/.config/gsimplecal
  ln -sfn ${dir}/config/gsimplecal/config ${HOME}/.config/gsimplecal/config

  #polybar
  mkdir -p ${HOME}/.config/polybar/
  ln -sfn ${dir}/config/polybar/config ${HOME}/.config/polybar/config
}

installFonts() {
  echo "Installing fonts"
  sleep 2
  yaourt --noconfirm -S ./yaourt_fonts.txt 
  mkdir -p ~/.local/share/fonts/
  wget "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20for%20Powerline%20Nerd%20Font%20Complete%20Mono.otf"
  sudo mv *.otf ~/.local/share/fonts/
  sudo fc-cache -fv
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
  
  # SSH agent
  mkdir -p ${HOME}/.config/systemd/user
  ln -sfn ${dir}/config/units/ssh-agent.service ${HOME}/.config/systemd/user/
  systemctl --user daemon-reload
  systemctl --user enable ssh-agent
  systemctl --user start ssh-agent

  # Global git ignores
  gibo -u
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
  installJs;

  # clojure lein configuration
  mkdir -p ${HOME}/.lein/
  ln -sfn ${dir}/config/lein/profiles.clj ${HOME}/.lein/profiles.clj

  #IntelliJ watches in the FS
  sudo bash -c 'echo "fs.inotify.max_user_watches = 524288" > /etc/sysctl.d/99-sysctl.conf'
  sudo sysctl --system
}

installjs() {
  yaourt --noconfirm nodejs
  sudo npm install -g n
  sudo n latest
}

installTools() {
  echo "Installing apps and tools"
  sleep 2
  yaourt --noconfirm -S ./yaourt_tools.txt
  sudo pip install thefuck
}

installRedshift() {
  echo "Installing redshift"
  sleep 2
  yaourt --noconfirm -S redshift
  mkdir -p ${HOME}/.config/redshift
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
  mkdir -p ~/.backup
  mkdir -p ~/.tmp
  mkdir -p ~/.vim/undodir
  vim +PlugInstall +qa
}

installRanger() { 
  yaourt -S ranger --noconfirm
  ranger --copy-config=scope
  ln -sfn ${dir}/config/ranger/config ${HOME}/.config/ranger/rc.conf
}

installMutt() {
  yaourt -S --noconfirm neomutt
  ln -sfn ${dir}/config/mutt/.muttrc ${HOME}/.muttrc
}

installKhal() { 
  sudo pip install khal vdirsyncer requests-oauthlib

  mkdir -p ${HOME}/.config/khal
  mkdir -p ${HOME}/.config/vdirsyncer

  ln -sfn ${dir}/config/khal/khal.conf ${HOME}/.config/khal/khal.conf
  cp ${dir}/config/khal/vdirsyncerconfig ${HOME}/.config/vdirsyncer/config
}

installAudio() { 
  yaourt -S --noconfirm ./yaourt_audio.txt
  asoundconf set-default-card PCH
  echo "pcm.dsp { type plug  slave.pcm \"dmix\" }" >> ${HOME}/.asoundrc.asoundconf
}

installCompton() {
  yaourt -S --noconfirm \
    compton \
    xorg-xwininfo
  mkdir -p ~/.before_startx
  echo "compton -c -i 0.9 -b &" >> ~/.before_startx/run.sh
  chmod a+x ~/.before_startx/run.sh
  ln -sfn ${dir}/config/compton/compton.conf ${HOME}/.config/compton.conf
}

installTaskWarrior() {
  yaourt -S --noconfirm task tasksh
  ln -sfn ${dir}/config/taskwarrior/.taskrc ${HOME}/.taskrc

  # time tracking hook
  sudo pip install taskwarrior-time-tracking-hook
  mkdir -p ~/.task/hooks
  ln -s `which taskwarrior_time_tracking_hook` ~/.task/hooks/on-modify.timetracking
}

installBeancount() {
  sudo pip install beancount beancount-fava setuptools beansoup beancount-plugins
}

dir=`pwd`
if [ ! -e "${dir}/${0}" ]; then
  echo "Script not called from within repository directory. Aborting."
  exit 2
fi
dir="${dir}/.."

echo "PaNaVTEC dotfiles installer"

mkdir -p ${HOME}/.data
mkdir -p ${HOME}/.i3

#Makes binary executable
chmod a+x ${dir}/bin/*

#TODO: this autommagically
echo "Remember that you need to uncommed the [multilib] repo in /etc/pacman.conf, if you haven't done that, please modify that file, update with pacman -Syua and come back later"
echo "actionSystem.suspendFocusTransferIfApplicationInactive=false add this into intelliJ to prevent focus lose"

echo "Don't forget to add your Github SSH key with: ssh-add ~/.ssh/id_rsa when you copied it"

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
ask "Install Ranger?" Y && installRanger; 
ask "Install Khal?" Y && installKhal;
ask "Install taskWarrior?" Y && installTaskWarrior;
ask "Install beancount?" Y && installBeancount;
ask "Install mutt?" Y && installMutt;
