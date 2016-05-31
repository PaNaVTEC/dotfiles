#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
[[ -f ~/.git-completion.bash ]] && . ~/dotfiles/git-completion.bash
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
