#!/bin/bash -e

docker_stop_all() {
  docker stop $(docker ps -a -q)
}

docker_prune() {
  docker system prune
  docker rmi $(docker images -a -q)
}

# Taken from: https://github.com/dflock/docker_aliases
# Figure out if we need to use sudo for docker commands
if id -nG "$USER" | grep -qw "docker"; then
  dsudo=''
else
  dsudo='sudo'
fi

# Simple Docker aliases
alias di='$dsudo docker images'

#
#  List the RAM used by a given container.
#  Used by dps().
#
#  docker_mem <container name|id>
#
docker_mem() {
  if [ -f /sys/fs/cgroup/memory/docker/"$1"/memory.usage_in_bytes ]; then
    echo $(( $(cat /sys/fs/cgroup/memory/docker/"$1"/memory.usage_in_bytes) / 1024 / 1024 )) 'MB'
  else
    echo 'n/a'
  fi
}

#
# Return the ID of the container, given the name.
#
# docker_id <container_name>
#
docker_id() {
  id=$( $dsudo docker inspect --format="{{.Id}}" "$1" 2> /dev/null);
  if (( $? >= 1 )); then
    # Container doesn't exist
    id=''
  fi
  echo $id
}

#
# Return the status of the named container.
#
# docker_up <container_name>
#
docker_up() {
  up='Y'
  id=$( $dsudo docker inspect --format="{{.Id}}" "$1" 2> /dev/null);
  if (( $? >= 1 )); then
    # Container doesn't exist
    up='N'
  fi
  echo "$up"
}

#
#  List the IP address for a given container:
#  Used by dps().
#
#  docker_ip <container name|id>
#
docker_ip() {
  ip=$($dsudo docker inspect --format="{{.NetworkSettings.IPAddress}}" "$1" 2> /dev/null)
  if (( $? >= 1 )); then
    # Container doesn't exist
    ip='n/a'
  fi
  echo $ip
}

#
# Enhanced version of 'docker ps' which outputs two extra columns:
#
# IP  : The private IP address of the container
# RAM : The amount of RAM the processes inside the container are using
#
# Usage: same as 'docker ps', but 'dps', so 'dps -a', etc...
#
docker_ps() {
  tmp=$($dsudo docker ps "$@")
  headings=$(echo "$tmp" | head --lines=1)
  max_len=$(echo "$tmp" | wc --max-line-length)
  dps=$(echo "$tmp" | tail --lines=+2)

  printf "%-${max_len}s %-15s %10s\n" "$headings" IP RAM
  if [[ -n "$dps" ]]; then
    while read -r line; do
      container_short_hash=$( echo "$line" | cut -d' ' -f1 );
      container_long_hash=$( $dsudo docker inspect --format="{{.Id}}" "$container_short_hash" );
      container_name=$( echo "$line" | rev | cut -d' ' -f1 | rev )
      if [ -n "$container_long_hash" ]; then
        ram=$(docker_mem "$container_long_hash");
        ip=$(docker_ip "$container_name");
        printf "%-${max_len}s %-15s %10s\n" "$line" "$ip" "${ram}";
      fi
    done <<< "$dps"
  fi
}
alias dps='docker_ps'

#
#  List the volumes for a given container:
#
#  docker_vol <container name|id>
#
docker_vol() {
  vols=$($dsudo docker inspect --format="{{.HostConfig.Binds}}" "$1")
  vols=${vols:1:-1}
  for vol in $vols
  do
    echo "$vol"
  done
}


#
# Remove any dangling images & exited containers
#
docker_clean() {
  echo "Removing dangling images:"
  $dsudo docker rmi "$(docker images -f "dangling=true" -q)"
  echo "Removing exited containers:"
  $dsudo docker rm -v "$(docker ps -a -q -f status=exited)"
}
alias dclean='docker_clean'

#
#  List the links for a given container:
#
#  docker_links <container name|id>
#
docker_links() {
  links=$($dsudo docker inspect --format="{{.HostConfig.Links}}" "$1")
  # links=${vols:1:-1}
  for link in $links
  do
    echo "$link"
  done
}
alias dlinks='docker_links'

#
# Returns the systems init type as a string:
#
# 'upstart', 'systemd', 'sysv'
#
# Call like this:
#
# VAR_INIT_TYPE=$(init_type)
#
init_type() {
  if [[ $(file /sbin/init) =~ ELF ]]; then
    echo 'upstart';
  elif [[ $(systemctl) =~ -\.mount ]]; then
    echo 'systemd';
  elif [[ -f /etc/init.d/cron && ! -h /etc/init.d/cron ]]; then
    echo 'sysv';
  else
    echo 'unknown';
  fi
}

#
# Stops, starts or restarts the docker daemon.
# Should work on both upstart, systemd init systems.
#
# @1  The action to perform: start|stop|restart
#
docker_ctl() {
  local action="$1"
  local init=$(init_type)

  case $init in
    upstart)
      case $action in
        start )
          sudo start docker
          ;;
        stop )
          sudo stop docker
          ;;
        restart )
          sudo restart docker
          ;;
      esac
    ;;
    systemd)
      case $action in
        start )
          sudo systemctl start docker.service
          ;;
        stop )
          sudo systemctl stop docker.service
          ;;
        restart )
          sudo systemctl restart docker.service
          ;;
      esac
    ;;
  esac
}

#
#  Delete all containers & images,
#  reset dockers container linking DB and restart docker.
#  The nuclear option.
#
#  NB: Does not prompt for confirmation.
#
docker_wipe() {
  $dsudo docker rm -f $(docker ps -a -q)
  $dsudo docker rmi -f $(docker images -q)

  docker_ctl 'stop'

  sudo rm -rf /var/lib/docker/*

  docker_ctl 'start'
}

#
#  Perform a docker cmd on all docker containers
#
#  docker_all <cmd>
#
docker_all() {
  if [ "$#" -ne 1 ]; then
    echo "Usage: $0 start|stop|pause|unpause|<any valid docker cmd>"
  fi

  for c in $($dsudo docker ps -a | awk '{print $1}' | sed "1 d")
  do
    $dsudo docker "$1" "$c"
  done
}
alias dall='docker_all'
