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

  # Enable emojis on terminal, Qt and Gtk apps
  mkdir -p ~/.local/share/fonts/
  mkdir -p ~/.config/fontconfig/conf.d/

  yaourt -Rdd cairo && yaourt --noconfirm -S cairo-coloredemoji
  cp ${dir}/config/fonts/51-noto-color-emoji.conf /etc/fonts/conf.avail/
  cp ${dir}/config/fonts/fonts.conf ${HOME}/.config/fontconfig/
  yaourt --noconfirm -S ./yaourt_fonts.txt

  # Download Nerd Font (for glyphs)
  wget "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20for%20Powerline%20Nerd%20Font%20Complete%20Mono.otf"
  sudo mv *.otf ${HOME}/.local/share/fonts/

  # Set font fallback configuration in place
  ln -sfn ${dir}/config/fontconfig/10-icons.conf ${HOME}/.config/fontconfig/conf.d/10-icons.conf

  # Refresh user and global font paths
  fc-cache -fv
  sudo fc-cache -fv

  # Install vcconsole.font & colors
  yaourt --noconfirm -S setcolors-git
  cp ${dir}/config/fontconfig/vconsole.conf /etc/

  sudo sed -i /etc/mkinitcpio.conf -e 's/^\\\(HOOKS=\"base\s\)\([^\"]\+\)\"/\1colors consolefont \2"/'
  sudo mkinitcpio -p linux
}

installThemes() {
  echo "Installing themes"
  sleep 2
  yaourt --noconfirm -S ./yaourt_themes.txt
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
  gibo --upgrade
  gibo Vim JetBrains Tags Vagrant Windows macOS Linux Archives >> ~/.gitignore.global
  echo ".ensime*" >> ~/.gitignore.global
  echo ".tern-project" >> ~/.gitignore.global
}

installDevTools() {
  echo "Installing developer tools"
  sleep 2

  installGit;
  yaourt --noconfirm -S ./yaourt_java.txt
  yaourt --noconfirm -S ./yaourt_android.txt
  yaourt --noconfirm -S ./yaourt_scala.txt
  yaourt --noconfirm -S ./yaourt_devtools.txt
  installJs;
  installClojure;
  installHaskell;
  installGo;

  # Docker
  rm -rf /var/lib/docker
  mkdir -p ${HOME}/.dockerlib
  sudo ln -sfn ${HOME}/.dockerlib /var/lib/docker

  #IntelliJ watches in the FS
  sudo bash -c 'echo "fs.inotify.max_user_watches = 524288" > /etc/sysctl.d/99-sysctl.conf'
  sudo sysctl --system
}

installGo() {
  yaourt --noconfirm -S go
  mkdir -p ${HOME}/go/{bin,src}
  go get -u github.com/golang/lint/golint
}

installHaskell() {
  sudo pacman-key -r 4209170B
  sudo pacman-key --lsign-key 4209170B
  sudo pacman-key -r B0544167
  sudo pacman-key --lsign-key B0544167
  yaourt -Syu

  yaourt -S haskell-stack haskell-stack-tool
  stack setup
  stack install ghc-mod hindent stylish-haskell cabal-install hoogle hlint ghc-mod
  cabal update
  echo "========"
  echo "Your GHC path will be: $(stack path | grep ghc-paths)"
  echo "========"
  ln -sfn ${dir}/ghci ${HOME}/.ghci
}

addPacmanSource() {
  sudo bash -c 'echo "['$1']" >> /etc/pacman.conf'
  sudo bash -c 'echo "Server = '$2'" >> /etc/pacman.conf'
}

installJs() {
  yaourt --noconfirm -S nodejs npm
  sudo npm install -g n
  sudo n latest
}

installClojure() {
  yaourt --noconfirm -S ./yaourt_clojure.txt
  mkdir -p ${HOME}/.lein/
  ln -sfn ${dir}/config/lein/profiles.clj ${HOME}/.lein/profiles.clj
  lein > /dev/null
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

installPacman() {
  sudo rm /etc/pacman.conf
  ln -sfn ${dir}/config/pacman/pacman.conf /etc/pacman.conf
  # Update mirrorlist
  sudo rm /etc/pacman.d/mirrorlist
  MIRRORLIST=$(curl -s \
    "https://www.archlinux.org/mirrorlist/?country=GB&protocol=http&protocol=https&ip_version=4")
  echo "$MIRRORLIST" | \
    sed 's/#Server/Server/g' | \
    sudo tee /etc/pacman.d/mirrorlist
  sudo pacman -Syy
  #Init keyring
  sudo pacman-key --init
  sudo pacman-key --populate archlinux
  sudo pacman -Syu
}

installYaourt() {
  installPacman;

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
}

compileVim() {
  VIM_BUILD_DIR=~
  cd "$VIM_BUILD_DIR"
  if [[ ! -d vim ]]; then
    git clone https://github.com/vim/vim.git --recursive
  else
    cd vim
    git pull
    git submodule update --init --recursive
    cd ..
  fi
  cd vim
  ./configure --with-features=huge \
    --enable-multibyte \
    --enable-rubyinterp \
    --enable-python3interp=yes \
    --enable-luainterp \
    --enable-gui=no \
    --enable-cscope \
    --enable-pythoninterp \
    --enable-python3interp
  make -j`nproc`
  sudo make install
}

installVim() {
  yaourt -S --noconfirm silver-searcher-git cmake sbt scalafmt

  # Ensime
  yaourt -S --noconfirm python2-sexpdata python2-websocket-client
  mkdir -p ~/.sbt/0.13/plugins/
  echo 'addSbtPlugin("org.ensime" % "sbt-ensime" % "1.12.14")' > ~/.sbt/0.13/plugins/plugins.sbt

  # Scala compilation errors with sbt
  git clone git@github.com:PaNaVTEC/sbt-vim-async-integration.git
  (cd sbt-vim-async-integration && sbt publishLocal)
  echo 'addSbtPlugin("zmre" % "sbt-vim-async-integration" % "1.0-LOCAL")' >> ~/.sbt/0.13/plugins/plugins.sbt
  mkdir -p ${HOME}/.vim/plugged/ale/ale_linters/scala
  ln -sfn ${dir}/config/vim/sbtlogs.vim ${HOME}/.vim/plugged/ale/ale_linters/scala/sbtlogs.vim

  (compileVim;)

  # Haskell-Vim
  wget https://raw.githubusercontent.com/sdiehl/haskell-vim-proto/master/vim/syntax/cabal.vim -P ~/.vim/syntax/
  wget https://raw.githubusercontent.com/sdiehl/haskell-vim-proto/master/vim/syntax/haskell.vim -P ~/.vim/syntax/

  #YouComplete me workarround for ncurses new version
  sudo ln -s /usr/lib/libtinfo.so.6 /usr/lib/libtinfo.so.5

  #Install plugin system 
  curl -fLo ${HOME}/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  #Vimwiki
  ln -sfn ${HOME}/Dropbox/vimwiki/ ${HOME}/vimwiki

  #Configuration
  ln -sfn ${dir}/config/vim/vimrc.vim ${HOME}/.vimrc

  mkdir -p ~/.backup
  mkdir -p ~/.tmp
  mkdir -p ~/.vim/undodir

  # installs tern for vim
  (cd ${HOME}/.vim/plugged/tern_for_vim && npm install)
  (cd ${HOME}/.vim/plugged/YouCompleteMe && ./install.py --tern-completer)

  # MDN Query plugin dependencies
  gem install mdn_query

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
  yaourt -S --noconfirm khal vdirsyncer

  mkdir -p ${HOME}/.config/khal
  mkdir -p ${HOME}/.config/vdirsyncer

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
  yaourt -S --noconfirm beancount fava
}

installPrivacy() {
  yaourt -S --noconfirm openvpn wireguard-dkms wireguard-tools
  sudo mkdir -p /etc/openvpn/
  sudo mkdir -p /etc/wireguard/
  sudo gpg -d --output /etc/openvpn/server.ovpn ${dir}/config/vpn/server.gpg
  sudo cp ${dir}/config/vpn/update-resolv-conf.sh /etc/openvpn
  sudo gpg -d --output /etc/wireguard/wg0-client.conf ${dir}/config/vpn/wg0-client.gpg
  sudo chown -v root:root /etc/wireguard/wg0-client.conf
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

echo "actionSystem.suspendFocusTransferIfApplicationInactive=false add this into intelliJ to prevent focus lose"
echo "Don't forget to add your Github SSH key with: ssh-add ~/.ssh/id_rsa when you copied it"

ask "install pacman/yaourt?" Y && installYaourt;
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
ask "Install privacy?" Y && installPrivacy;

