#!/bin/bash -e

relativePath="$DOTFILES_LOCATION/system"
source "$relativePath/update.sh"
#source /usr/bin/liquidprompt

source "$relativePath/prompt.sh"

if [[ $(uname) == "Darwin" ]]; then
  alias ls='ls -G'
else
  alias ls='ls --color=auto'
fi
alias ll='exa'
alias la='ll'
alias exa='exa -bghlaU --git --group-directories-first'
alias grep="grep --color=auto"
alias connectvpn='sudo toggle-openvpn.sh'
alias wireup='sudo wg-quick up wg0-client'
alias wiredown='sudo wg-quick down wg0-client'
alias dotfiles='(cd "$DOTFILES_LOCATION" && emacs -nw)'
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

backupSystem() {
  rsync -aAXv --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found"} / $1
}

alias trayer='trayer --width 30 --widthtype pixel --SetDockType false --edge top --align center'

cpuDrainers() {
  ps aux --sort %cpu | tail -5 | cut -c 22-150
}

setTermiteTitle() {
  echo `tput tsl` $1  `tput fsl`
}

forceHwClock() {
  #$1 = 2018-03-15
  sudo hwclock --set --date "$1"
  sudo systemctl restart systemd-timesyncd.service
}

dockerHotReloading() {
  # directory in /lib/modules
#  sudo depmod 4.15.6-1-ARCH
#  sudo modprobe --set-version=4.15.6-1-ARCH overlay bridge br_netfilter nf_nat xt_conntrack

#  uname () {
#    echo "4.15.6-1-ARCH"
#  }
  modprobe () {
    builtin modprobe --set-version=4.15.6-1-ARCH
  }
}
