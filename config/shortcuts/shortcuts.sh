#!/usr/bin/env bash

# Config locations
folders="$HOME/Dropbox/.sync/folders"
configs="$HOME/Dropbox/.sync/configs"

# Output locations
bash_shortcuts="$HOME/.bash_shortcuts"
ranger_shortcuts="$HOME/.config/ranger/shortcuts.conf"
qute_shortcuts="$HOME/.config/qutebrowser/shortcuts.py"

#Delete old shortcuts
echo "# vim: filewtype=sh" > $bash_shortcuts
echo "# ranger shortcuts" > $ranger_shortcuts
echo "# qutebrowser shortcuts" > $qute_shortcuts

writeDirs() { echo "alias $1='cd $2 && ls -a'" >> $bash_shortcuts
              echo "map g$1 cd $2" >> $ranger_shortcuts
              echo "map t$1 tab_new $2" >> $ranger_shortcuts
              echo "map m$1 shell mv -v %s $2" >> $ranger_shortcuts
              echo "map Y$1 shell cp -rv %s $2" >> $ranger_shortcuts
              echo "config.bind(';$1', 'set downloads.location.directory $2 ;; hint links download')" >> $qute_shortcuts ;}

writeConfs() {
  echo "alias $1='vim $2'" >> $bash_shortcuts
  echo "map $1 shell vim $2" >> $ranger_shortcuts ;}

IFS=$'\n'
set -f
for line in $(cat "$folders"); do
  line=$(echo $line | sed 's/#.*//')
  key=$(echo $line | awk '{print $1}')
  dir=$(echo $line | awk '{print $2}')
  [ "$dir" == "" ] || writeDirs $key $dir
done

set -f
for line in $(cat "$configs"); do
  line=$(echo $line | sed 's/#.*//')
  short=$(echo $line | awk '{print $1}')
  conf=$(echo $line | awk '{print $2}')
  [ "$conf" == "" ] || writeConfs $short $conf
done
