#!/usr/bin/env bash

relativePath="$DOTFILES_LOCATION/system"
source "$relativePath/update.sh"
source "$relativePath/wifi.sh"
source "$relativePath/bluetooth.sh"
source "$relativePath/music.sh"
source "$relativePath/tmux.sh"

if [[ $(uname) == "Darwin" ]]; then
  alias ls='ls -G'
else
  alias ls='ls --color=auto'
fi
alias ll='exa'
alias la='ll'
alias exa='exa -bghla --git --group-directories-first'
alias grep="grep --color=auto"
alias connectvpn='sudo toggle-openvpn.sh'
alias wireup='sudo wg-quick up wg0-client'
alias wiredown='sudo wg-quick down wg0-client'
alias dotfiles='(cd "$DOTFILES_LOCATION" && emacs -nw)'
alias ffs='sudo $(fc -ln -1)'
alias shortcuts="$DOTFILES_LOCATION/config/shortcuts/shortcuts.sh"
alias cls='printf "\033c"'
alias scriptinfo="grep -E '^[[:space:]]*([[:alnum:]_]+[[:space:]]*\(\)|alias[[:space:]]+[[:alnum:]_]+|function[[:space:]]+[[:alnum:]_]+)'"

availableCommands () {
  shopt -s extdebug
  declare -F | awk '{print $NF}' | while read func; do \
    declare -F $func; \
  done; \
  shopt -u extdebug
}

indexOf () {
  availableCommands | grep -E "$1.[[:alnum:]]+\$" | awk '{print $1}' | while read nFunc; do \
    type $nFunc | grep -v "is a function"; \
  done;
}

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

killByName() {
  pkill "$1"
}

showWifiPassword() {
  local path='/etc/NetworkManager/system-connections/'

  sudo grep -rH '^psk=' $path | awk -F '/' '{print $5}'
}

showPublicIp() {
  local content
  local ip
  local city
  local country
  content=$(curl -s ipinfo.io/)
  ip=$(echo "$content" | jq -r .ip)
  city=$(echo "$content" | jq -r .city)
  country=$(echo "$content" | jq -r .country)
  echo "$ip - $city ($country)"
}

showListeningPorts() {
  sudo netstat -tulpn | grep LISTEN
}

cpuDrainers() {
  ps aux --sort %cpu | tail -5 | cut -c 22-150
}

forceHwClock() {
  #$1 = 2018-03-15
  sudo hwclock --set --date "$1"
  sudo systemctl restart systemd-timesyncd.service
}

portOfProcessNamed() {
  netstat -tlpn  | grep "$1"
}

setSshPermissions() {
  chmod 700 ~/.ssh
  chmod 644 ~/.ssh/authorized_keys
  chmod 644 ~/.ssh/known_hosts
  chmod 644 ~/.ssh/config
  chmod 600 ~/.ssh/id_rsa
  chmod 644 ~/.ssh/id_rsa.pub
}
