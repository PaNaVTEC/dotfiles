dotfilesLocation=~/dotfiles
alias ls='ls --color=auto'
alias ll='exa'
alias la='ll'
alias exa='exa -bghlaU --git --group-directories-first'
alias ccat='pygmentize -g'
alias ccatl='pygmentize -g -O style=colorful,linenos=1'
alias y='yaourt'
alias ys='yaourt -Ss'
alias yi='yaourt -S'
alias yin='yi --noconfirm'
alias yunf='yu --noconfirm --force'
alias yp='yaourt -Qm'
alias yr='yaourt -R'
alias v='vim --servername VIM'
alias vi='vim --servername VIM'
alias vim='vim --servername VIM'
alias grep="grep --color=auto"
alias connectvpn='sudo openvpn /etc/openvpn/server.ovpn'
alias wireup='sudo wg-quick up wg0-client'
alias wiredown='sudo wg-quick down wg0-client'
alias dotfiles='(cd "$dotfilesLocation" && vim -c NERDTree)'
alias ffs='sudo $(fc -ln -1)'
alias et='emacsclient -nw'
alias ew='emacsclient'
alias e='emacsclient'

autogeneratePassword () {
  LC_CTYPE=C tr -dc "[:alnum:]" < /dev/urandom | fold "-w${1:-32}" | head -1
}

alias yu='systemUpdate;'
alias yun='systemUpdate "--noconfirm";'
vimUpdate () {
  echo "Upgrade VIM"
  (source "$dotfilesLocation/setup/setup.sh" && compileVim;)

  echo "Upgrading vim plugins"
  vim +PlugClean +PlugUpgrade +PlugUpdate +qa
}

systemUpdate () {
  echo "Updating dotfiles"
  (cd "$dotfilesLocation" && git pull)

  echo "Upgrading global Js packages"
  sudo yarn global upgrade

  vimUpdate;

  echo "Upgrading system packages"
  yaourt -Syua "$1"
}


every() {
  watch -c -n "$1" "$2"
}

alias trayer='trayer --width 30 --widthtype pixel --SetDockType false --edge top --align center'
