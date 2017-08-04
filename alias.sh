alias ls='ls --color=auto'
alias ll='ls -la --color=auto'
alias la='ll'
alias ccat='pygmentize -g'
alias ccatl='pygmentize -g -O style=colorful,linenos=1'
alias wear_emulator='adb -d forward tcp:5601 tcp:5601'
alias wear_device='adb forward tcp:4444 localabstract:/adb-hub; adb connect localhost:4444'
alias y='yaourt'
alias ys='yaourt -Ss'
alias yi='yaourt -S'
alias yin='yi --noconfirm'
alias yu='yaourt -Syua'
alias yun='yu --noconfirm'
alias yunf='yu --noconfirm --force'
alias yp='yaourt -Qm'
alias yr='yaourt -R'
alias v='vim'
alias vimScala='vim --servername VIM'
alias grep="grep --color=auto"

alias connectvpn='sudo openvpn /etc/openvpn/server.ovpn'
alias wireup='sudo wg-quick up wg0-client'
alias wiredown='sudo wg-quick down wg0-client'
alias dotfiles='(cd ~/dotfiles && vim -c NERDTree)'

javaProject () { 
  gradle init --type java-library
  sed '$itestCompile "org.mockito:mockito-all:1.10.19"' build.gradle >> build.gradle
  gradle --refresh-dependencies
}

scalaProject () {
  mkdir -p $1
  sbt new scala/hello-world.g8 --name=$1
  echo 'libraryDependencies += "org.scalactic" %% "scalactic" % "3.0.1"' >> $1/build.sbt
  echo 'libraryDependencies += "org.scalatest" %% "scalatest" % "3.0.1" % "test"' >> $1/build.sbt
  echo 'addSbtPlugin("org.scalastyle" %% "scalastyle-sbt-plugin" % "0.9.0")' >> $1/project/plugins.sbt
  cd $1
  sbt ensimeConfig
  sbt scalastyleGenerateConfig
}

clojureProject() {
  lein new $1
}

every() {
  watch -c -n $1 $2
}
