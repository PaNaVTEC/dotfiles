#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/panavtec/.sdkman"
[[ -s "/home/panavtec/.sdkman/bin/sdkman-init.sh" ]] && source "/home/panavtec/.sdkman/bin/sdkman-init.sh"
