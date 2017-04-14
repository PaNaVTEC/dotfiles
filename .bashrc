# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export XDG_CONFIG_HOME=$HOME/.config
export JAVA8_HOME=/usr/lib/jvm/java-8-jdk/
export BROWSER=firefox
export EDITOR=vim
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

source ~/dotfiles/prompt.sh
source ~/dotfiles/git-completion.bash
source ~/dotfiles/git-alias.sh
source ~/dotfiles/functions.sh
source ~/dotfiles/alias.sh
source ~/dotfiles/paths.sh
source ~/.env.sh

# Use omtc in firefox (enables html5 youtube hi quality videos)
export MOZ_USE_OMTC=1

# Set keyboard to US
setxkbmap -layout us -variant altgr-intl -option nodeadkeys

eval $(dircolors ~/.dircolors)

source /etc/profile.d/autojump.bash
