[[ $- != *i* ]] && return

export XDG_CONFIG_HOME=$HOME/.config
export BROWSER=inox
export EDITOR=vim
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export DOTFILES_LOCATION=~/dotfiles

source ~/dotfiles/git-completion.bash
source ~/dotfiles/git-alias.sh
source ~/dotfiles/git-alias-custom.sh
source "$DOTFILES_LOCATION/programming/index.sh"
source "$DOTFILES_LOCATION/system/index.sh"
source ~/dotfiles/paths.sh
source ~/.env.sh

setxkbmap -layout us -variant altgr-intl -option nodeadkeys

eval $(dircolors ~/.dircolors)

source /etc/profile.d/autojump.bash
