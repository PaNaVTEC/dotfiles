[[ $- != *i* ]] && return

export XDG_CONFIG_HOME=$HOME/.config
export JAVA8_HOME=/usr/lib/jvm/java-8-jdk/
export BROWSER=inox
export EDITOR=vim
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export ANDROID_HOME=~/Android/Sdk

source ~/dotfiles/prompt.sh
source ~/dotfiles/git-completion.bash
source ~/dotfiles/git-alias.sh
source ~/dotfiles/functions.sh
source ~/dotfiles/alias.sh
source ~/dotfiles/paths.sh
source ~/.env.sh

setxkbmap -layout us -variant altgr-intl -option nodeadkeys

eval $(dircolors ~/.dircolors)

source /etc/profile.d/autojump.bash
