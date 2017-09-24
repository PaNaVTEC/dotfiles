#!/bin/bash -e

export ANDROID_HOME=~/Android/Sdk
export JAVA8_HOME=/usr/lib/jvm/java-8-jdk/

relativePath="$DOTFILES_LOCATION/programming"

source "$relativePath/javascript.sh"
source "$relativePath/clojure.sh"
source "$relativePath/docker.sh"
source "$relativePath/scala.sh"
source "$relativePath/java.sh"
source "$relativePath/editors.sh"
source "$relativePath/git-completion.bash"
source "$relativePath/git-alias.sh"
source "$relativePath/git-alias-custom.sh"

source /etc/profile.d/autojump.bash
