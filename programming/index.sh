#!/bin/bash -e

export ANDROID_HOME="$HOME/Android/Sdk"
export JAVA8_HOME="/usr/lib/jvm/java-8-jdk/"

relativePath="$DOTFILES_LOCATION/programming"

source "$relativePath/javascript.sh"
source "$relativePath/clojure.sh"
source "$relativePath/docker.sh"
source "$relativePath/scala.sh"
source "$relativePath/java.sh"
source "$relativePath/haskell.sh"
source "$relativePath/editors.sh"
source "$relativePath/git-alias.sh"
source "/usr/local/bin/git-completion.bash"
source "$relativePath/git-alias-custom.sh"
source "$relativePath/ssl.sh"

[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
[ -f /usr/share/autojump/autojump.bash ] && . /usr/share/autojump/autojump.bash
[ -f /etc/profile.d/autojump.bash ] && . /etc/profile.d/autojump.bash
