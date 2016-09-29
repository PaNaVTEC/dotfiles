# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# use gtk for java apps
# export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'

export XDG_CONFIG_HOME=$HOME/.config
export JAVA8_HOME=/usr/lib/jvm/java-8-jdk/
export BROWSER=firefox
export EDITOR=vim

source ~/dotfiles/prompt.sh
source ~/dotfiles/git-completion.bash
source ~/dotfiles/git-alias.sh
source ~/dotfiles/functions.sh
source ~/dotfiles/alias.sh
source ~/dotfiles/paths.sh

# Use omtc in firefox (enables html5 youtube hi quality videos)
export MOZ_USE_OMTC=1

# Set keyboard to US
setxkbmap -layout us -variant altgr-intl -option nodeadkeys

eval $(dircolors ~/.dircolors)

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="~/.sdkman"
[[ -s "~/.sdkman/bin/sdkman-init.sh" ]] && source "~/.sdkman/bin/sdkman-init.sh"
