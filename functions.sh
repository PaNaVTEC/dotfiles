## COLORED MANUAL PAGES #{{{  
# @see http://www.tuxarena.com/?p=508
# For colourful man pages (CLUG-Wiki style)
if $_isxrunning; then
  export PAGER=less
  export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
  export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
  export LESS_TERMCAP_me=$'\E[0m'           # end mode
  export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
  export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
  export LESS_TERMCAP_ue=$'\E[0m'           # end underline
  export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline
fi
#}}}


# TOP 10 COMMANDS {{{
# copyright 2007 - 2010 Christopher Bratusek
top10() { history | awk '{a[$2]++ } END{for(i in a){print a[i] " " i}}' | sort -rn | head; }
#}}}

# UP {{{
# Goes up many dirs as the number passed as argument, if none goes up by 1 by default
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
#}}}

# ARCHIVE EXTRACTOR {{{
extract() {
  clrstart="\033[1;34m"  #color codes
  clrend="\033[0m"

  if [[ "$#" -lt 1 ]]; then
    echo -e "${clrstart}Pass a filename. Optionally a destination folder. You can also append a v for verbose output.${clrend}"
    exit 1 #not enough args
  fi

  if [[ ! -e "$1" ]]; then
    echo -e "${clrstart}File does not exist!${clrend}"
    exit 2 #file not found
  fi

  if [[ -z "$2" ]]; then
    DESTDIR="." #set destdir to current dir
  elif [[ ! -d "$2" ]]; then
    echo -e -n "${clrstart}Destination folder doesn't exist or isnt a directory. Create? (y/n): ${clrend}"
    read response
    #echo -e "\n"
    if [[ $response == y || $response == Y ]]; then
      mkdir -p "$2"
      if [ $? -eq 0 ]; then
        DESTDIR="$2"
      else
        exit 6 #Write perms error
      fi
    else
      echo -e "${clrstart}Closing.${clrend}"; exit 3 # n/wrong response
    fi
  else
    DESTDIR="$2"
  fi

  if [[ ! -z "$3" ]]; then
    if [[ "$3" != "v" ]]; then
      echo -e "${clrstart}Wrong argument $3 !${clrend}"
      exit 4 #wrong arg 3
    fi
  fi

  filename=`basename "$1"`

  #echo "${filename##*.}" debug

  case "${filename##*.}" in
    tar)
      echo -e "${clrstart}Extracting $1 to $DESTDIR: (uncompressed tar)${clrend}"
      tar x${3}f "$1" -C "$DESTDIR"
      ;;
    gz)
      echo -e "${clrstart}Extracting $1 to $DESTDIR: (gip compressed tar)${clrend}"
      tar x${3}fz "$1" -C "$DESTDIR"
      ;;
    tgz)
      echo -e "${clrstart}Extracting $1 to $DESTDIR: (gip compressed tar)${clrend}"
      tar x${3}fz "$1" -C "$DESTDIR"
      ;;
    xz)
      echo -e "${clrstart}Extracting  $1 to $DESTDIR: (gip compressed tar)${clrend}"
      tar x${3}f -J "$1" -C "$DESTDIR"
      ;;
    bz2)
      echo -e "${clrstart}Extracting $1 to $DESTDIR: (bzip compressed tar)${clrend}"
      tar x${3}fj "$1" -C "$DESTDIR"
      ;;
    zip)
      echo -e "${clrstart}Extracting $1 to $DESTDIR: (zipp compressed file)${clrend}"
      unzip "$1" -d "$DESTDIR"
      ;;
    rar)
      echo -e "${clrstart}Extracting $1 to $DESTDIR: (rar compressed file)${clrend}"
      unrar x "$1" "$DESTDIR"
      ;;
    7z)
      echo -e  "${clrstart}Extracting $1 to $DESTDIR: (7zip compressed file)${clrend}"
      7za e "$1" -o"$DESTDIR"
      ;;
    *)
      echo -e "${clrstart}Unknown archieve format!"
      exit 5
      ;;
  esac
}
#}}}

# ARCHIVE COMPRESS {{{
compress() {
  if [[ -n "$1" ]]; then
    FILE=$1
    case $FILE in
      *.tar ) shift && tar cf $FILE $* ;;
      *.tar.bz2 ) shift && tar cjf $FILE $* ;;
      *.tar.gz ) shift && tar czf $FILE $* ;;
      *.tgz ) shift && tar czf $FILE $* ;;
      *.zip ) shift && zip $FILE $* ;;
      *.rar ) shift && rar $FILE $* ;;
    esac
  else
    echo "usage: compress <foo.tar.gz> ./foo ./bar"
  fi
}
#}}}

# FILE & STRINGS RELATED FUNCTIONS {{{
## FIND A FILE WITH A PATTERN IN NAME {{{
ff() { find . -type f -iname '*'$*'*' -ls ; }
#}}}
## FIND A FILE WITH PATTERN $1 IN NAME AND EXECUTE $2 ON IT {{{
fe() { find . -type f -iname '*'$1'*' -exec "${2:-file}" {} \;  ; }
#}}}
## MOVE FILENAMES TO LOWERCASE {{{
lowercase() {
  for file ; do
    filename=${file##*/}
    case "$filename" in
      */* ) dirname==${file%/*} ;;
      * ) dirname=.;;
    esac
    nf=$(echo $filename | tr A-Z a-z)
    newname="${dirname}/${nf}"
    if [[ "$nf" != "$filename" ]]; then
      mv "$file" "$newname"
      echo "lowercase: $file --> $newname"
    else
      echo "lowercase: $file not changed."
    fi
  done
}
#}}}

# Removes orphan packages with paman
orphans() {
  if [[ ! -n $(pacman -Qdt) ]]; then
    echo "No orphans to remove."
  else
    sudo pacman -Rns $(pacman -Qdtq)
  fi
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

cdls() { cd "$@" && ls; }

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

docker_stop_all() {
  docker stop $(docker ps -a -q)
}

backupSystem() {
  rsync -aAXv --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found"} / $1
}

