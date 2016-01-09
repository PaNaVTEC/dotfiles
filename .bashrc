#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Removes orphan packages with pacman
orphans() {
  if [[ ! -n $(pacman -Qdt) ]]; then
    echo "No orphans to remove."
  else
    sudo pacman -Rns $(pacman -Qdtq)
  fi
}

# Paths
export PATH=${PATH}:/home/panavtec/Android/Sdk/tools/
export PATH=${PATH}:/home/panavtec/Android/Sdk/platform-tools/
export PATH=${PATH}:/opt/pypy3/bin/
export PATH=${PATH}:/home/panavtec/.bin/

#Current aliases
alias ls='ls --color=auto'
alias manupdate='sudo systemctl start man-db.service'

# Sets command prompt format
PS1='[\u@\h \W]\$ '

# Sets the default editor for commands like visudo
export EDITOR="$(if [[ -n $DISPLAY ]]; then echo 'atom'; else echo 'nano'; fi)"

setxkbmap -layout us -variant altgr-intl -option nodeadkeys

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/panavtec/.sdkman"
[[ -s "/home/panavtec/.sdkman/bin/sdkman-init.sh" ]] && source "/home/panavtec/.sdkman/bin/sdkman-init.sh"
