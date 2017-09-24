#!/bin/bash -e

relativePath="$DOTFILES_LOCATION/system"
source "$relativePath/update.sh"

alias ls='ls --color=auto'
alias ll='exa'
alias la='ll'
alias exa='exa -bghlaU --git --group-directories-first'
alias ccat='pygmentize -g'
alias ccatl='pygmentize -g -O style=colorful,linenos=1'
alias grep="grep --color=auto"
alias connectvpn='sudo openvpn /etc/openvpn/server.ovpn'
alias wireup='sudo wg-quick up wg0-client'
alias wiredown='sudo wg-quick down wg0-client'
alias dotfiles='(cd "$DOTFILES_LOCATION" && vim -c NERDTree)'
alias ffs='sudo $(fc -ln -1)'

autogeneratePassword () {
  LC_CTYPE=C tr -dc "[:alnum:]" < /dev/urandom | fold "-w${1:-32}" | head -1
}

every() {
  watch -c -n "$1" "$2"
}

alias trayer='trayer --width 30 --widthtype pixel --SetDockType false --edge top --align center'
