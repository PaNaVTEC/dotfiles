#!/bin/bash -e

relativePath="$DOTFILES_LOCATION/system"
source "$relativePath/update.sh"
source "$relativePath/prompt.sh"

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

up() {
  local d=""
  limit=$1
  for ((i=1 ; i <= limit ; i++)); do
    d=$d/..
  done
  d=$(echo $d | sed 's/^\///')
  if [[ -z "$d" ]]; then
    d=..
  fi
  cd $d
}

kernelModuleParameters() {
  cat /proc/modules | cut -f 1 -d " " | while read module; do \
    echo "Module: $module"; \
    if [ -d "/sys/module/$module/parameters" ]; then \
      ls /sys/module/$module/parameters/ | while read parameter; do \
      echo -n "Parameter: $parameter --> "; \
      cat /sys/module/$module/parameters/$parameter; \
    done; \
  fi; \
  echo; \
done
}

killByName() {
  kill $(ps aux | grep $1 | awk '{print $2}')
}

showWifiPassword() {
  path='/etc/NetworkManager/system-connections/'
  if [ $# -eq 0 ]; then
    path="$path*"
  else
    path="$path$1"
  fi
  sudo grep -H '^psk=' $path | awk -F '/' '{print $5}'
}

showPublicIp() {
  IP=$(curl -s ipinfo.io/ip)
  CITY=$(curl -s ipinfo.io/city)
  echo $IP "-" $CITY
}

showListeningPorts() {
  sudo netstat -tulpn | grep LISTEN
}

backupSystem() {
  rsync -aAXv --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found"} / $1
}

alias trayer='trayer --width 30 --widthtype pixel --SetDockType false --edge top --align center'
