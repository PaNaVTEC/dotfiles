#!/usr/bin/env bash
set -e

ask() {
  # https://djm.me/ask
  local prompt default reply

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

    # Ask the question (not using "read -p" as it uses stderr not stdout)
    echo -n "$1 [$prompt] "

    # Read the answer (use /dev/tty in case stdin is redirected from somewhere else)
    read reply </dev/tty

    # Default?
    if [ -z "$reply" ]; then
      reply=$default
    fi

    # Check if the reply is valid
    case "$reply" in
      Y*|y*) return 0 ;;
      N*|n*) return 1 ;;
    esac

  done
}

installi3() {
  echo "Installing i3 and required tools"
  sleep 2
  yaourt --noconfirm -S ./yaourt_i3.txt
}

installFonts() {
  echo "Installing fonts"
  sleep 2

  yaourt --noconfirm -S ./yaourt_fonts.txt

  # Download Nerd Font (for glyphs)
  wget "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20for%20Powerline%20Nerd%20Font%20Complete%20Mono.otf"
  mkdir -p "$HOME/.local/share/fonts/"
  sudo mv "*.otf" "$HOME/.local/share/fonts/"

  # Set font fallback configuration in place
  mkdir -p "$HOME/.config/fontconfig/conf.d/"
  ln -sfn "$dir/config/fontconfig/10-icons.conf" "$HOME/.config/fontconfig/conf.d/10-icons.conf"

  # Refresh user and global font paths
  fc-cache -fv
  sudo fc-cache -fv

  # Install vcconsole.font & colors
  yaourt --noconfirm -S mkinitcpio-colors-git

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

  # Global git ignores
  gibo --upgrade
  gibo dump Emacs Vim JetBrains Ensime Tags Vagrant Windows macOS Linux Archives >> "$HOME/.gitignore.global"
  echo ".tern-project" >> "$HOME/.gitignore.global"
  echo ".tern-port" >> "$HOME/.gitignore.global"
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
  installBash;
  installRust;

  # Docker
  rm -rf /var/lib/docker
  mkdir -p "$HOME/.dockerlib"
  sudo ln -sfn "$HOME/.dockerlib" "/var/lib/docker"

  #IntelliJ watches in the FS
  sudo bash -c 'echo "fs.inotify.max_user_watches = 524288" > /etc/sysctl.d/99-sysctl.conf'
  sudo sysctl --system
}

installRust () {
  yaourt --noconfirm -S rustup
  rustup toolchain install stable
  rustup default stable
  rustup toolchain install nightly
}

installBash() {
  yaourt --noconfirm -S shellcheck-static shunit2
}

installGo() {
  yaourt --noconfirm -S go
  mkdir -p "$HOME/go/{bin,src}"
  go get -u github.com/golang/lint/golint
}

installHaskell() {
  yaourt --noconfirm -S stack-bin
  stack setup
  stack install ghc-mod hindent stylish-haskell cabal-install hoogle hlint
  echo "========"
  echo "Your GHC path will be: $(stack path | grep ghc-paths)"
  echo "========"
  hoogle generate
}

installJs() {
  yaourt --noconfirm -S nodejs npm yarn
  yarn config set -- --emoji true
  sudo yarn global add n
  sudo n latest
  yarn global add tern standard create-react-app js-beautify
  yarn global add typescript tslint eslint-plugin-typescript typescript-eslint-parser
}

installClojure() {
  yaourt --noconfirm -S ./yaourt_clojure.txt
}

installTools() {
  echo "Installing apps and tools"
  sleep 2

  yaourt --noconfirm -S ./yaourt_tools.txt
  yaourt --noconfirm -S ./yaourt_urxvt.txt

  yaourt --noconfirm -S powerline-go-bin
  # setup qutebrowser
  yaourt --noconfirm -S qutebrowser

  # setup inox
  yaourt --noconfirm -S maninex
  sudo mkdir -p /usr/share/inox/extensions
  sudo mkdir -p "$HOME/.config/inox/extensions"

  yaourt --noconfirm -S openresolv
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

installPacman() {
  sudo rm /etc/pacman.conf
  ln -sfn "$dir/config/pacman/pacman.conf" "/etc/pacman.conf"
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
  (cd package-query && makepkg -si)
  rm -rf package-query
  rm package-query.tar.gz
  wget https://aur.archlinux.org/cgit/aur.git/snapshot/yaourt.tar.gz
  tar xvfz yaourt.tar.gz
  (cd yaourt && makepkg -si)
  rm -rf yaourt
  rm yaourt.tar.gz

  yaourt -S --noconfirm reflector
}

installVim() {
  yaourt -S --noconfirm cmake sbt scalafmt vim

  # Haskell-Vim
  wget https://raw.githubusercontent.com/sdiehl/haskell-vim-proto/master/vim/syntax/cabal.vim -P "$HOME/.vim/syntax/"
  wget https://raw.githubusercontent.com/sdiehl/haskell-vim-proto/master/vim/syntax/haskell.vim -P "$HOME/.vim/syntax/"

  #YouComplete me workarround for ncurses new version
  sudo ln -sfn /usr/lib/libtinfo.so.6 /usr/lib/libtinfo.so.5

  #Install plugin system
  curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  #Vimwiki
  ln -sfn "$HOME/Dropbox/.sync/vimwiki/" "$HOME/vimwiki"

  #Configuration
  ln -sfn "$dir/config/vim/vimrc.vim" "$HOME/.vimrc"

  mkdir -p "$HOME/.backup"
  mkdir -p "$HOME/.tmp"
  mkdir -p "$HOME/.vim/undodir"

  # installs tern for vim
  (cd "$HOME/.vim/plugged/tern_for_vim" && npm install)
  (cd "$HOME/.vim/plugged/YouCompleteMe" && ./install.py --tern-completer)

  # MDN Query plugin dependencies
  gem install mdn_query

  vim +PlugInstall +qa
}

installEmacs() {
  yaourt -S --noconfirm emacs aspell aspell-en aspell-es
}

installRanger() {
  yaourt -S ranger w3m ffmpegthumbnailer atool --noconfirm
}

installMutt() {
  yaourt -S --noconfirm neomutt
}

installAudio() {
  yaourt -S --noconfirm ./yaourt_audio.txt
}

installCompton() {
  yaourt -S --noconfirm compton xorg-xwininfo
  mkdir -p "$HOME/.before_startx"
  echo "compton -c -i 0.9 -b &" >> "$HOME/.before_startx/run.sh"
  chmod a+x "$HOME/.before_startx/run.sh"
}

installTaskWarrior() {
  yaourt -S --noconfirm task tasksh
}

installBeancount() {
  yaourt -S --noconfirm beancount fava
}

installPrivacy() {
  yaourt -S --noconfirm openvpn wireguard-dkms wireguard-tools
  sudo mkdir -p /etc/openvpn/
  sudo mkdir -p /etc/wireguard/
  sudo gpg -d --output /etc/openvpn/server.ovpn "$dir/config/vpn/server.gpg"
  sudo cp "${dir}/config/vpn/update-resolv-conf.sh" /etc/openvpn
  sudo gpg -d --output /etc/wireguard/wg0-client.conf "$dir/config/vpn/wg0-client.gpg"
  sudo chown -v root:root /etc/wireguard/wg0-client.conf
}

installBt() {
  yaourt -S --noconfirm bluez bluez-utils bluez-qt pulseaudio-bluetooth
  modprobe btusb
  sudo systemctl enable bluetooth.service
  sudo systemctl start bluetooth.service
}

if [[ "${BASH_SOURCE[0]}" = "$0" ]]; then

  echo "PaNaVTEC dotfiles installer"

  dir=$(pwd)
  if [ ! -e "${dir}/${0}" ]; then
    echo "Script not called from within repository directory. Aborting."
    exit 2
  fi
  dir="${dir}/.."

  mkdir -p "$HOME/.data"
  mkdir -p "$HOME/.i3"

  echo "actionSystem.suspendFocusTransferIfApplicationInactive=false add this into intelliJ to prevent focus lose"

  ask "install pacman/yaourt?" Y && installYaourt;
  ask "install i3?" Y && installi3;
  ask "install compton?" Y && installCompton;
  ask "install fonts?" Y && installFonts;
  ask "install dev tools?" Y && installDevTools;
  ask "install apps and tools?" Y && installTools;
  ask "install themes?" Y && installThemes;
  ask "install vim config?" Y && installVim;
  ask "install emacs?" Y && installEmacs;
  ask "install audio?" Y && installAudio;
  ask "install bt?" Y && installBt;

  ask "Install redshift?" Y && installRedshift
  ask "Install symlink for .xinitrc?" Y && ln -sfn "$dir/.xinitrc" "$HOME/.xinitrc"
  ask "Install symlink for .bashrc?" Y && ln -sfn "$dir/.bashrc" "$HOME/.bashrc"
  ask "Install symlink for .bash_profile?" Y && ln -sfn "$dir/.bash_profile" "$HOME/.bash_profile"

  ask "Install screensavers?" Y && installScreensavers;
  ask "Install Ranger?" Y && installRanger;
  ask "Install taskWarrior?" Y && installTaskWarrior;
  ask "Install beancount?" Y && installBeancount;
  ask "Install mutt?" Y && installMutt;
  ask "Install privacy?" Y && installPrivacy;
fi
