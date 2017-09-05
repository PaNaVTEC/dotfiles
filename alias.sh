dotfilesLocation=~/dotfiles
alias ls='ls --color=auto'
alias ll='ls -la --color=auto'
alias la='ll'
alias exa='exa -bghlaU --git --group-directories-first'
alias ccat='pygmentize -g'
alias ccatl='pygmentize -g -O style=colorful,linenos=1'
alias y='yaourt'
alias ys='yaourt -Ss'
alias yi='yaourt -S'
alias yin='yi --noconfirm'
alias yu="(cd $dotfilesLocation && git pull) && yaourt -Syua"
alias yun='yu --noconfirm'
alias yunf='yu --noconfirm --force'
alias yp='yaourt -Qm'
alias yr='yaourt -R'
alias v='vim --servername VIM'
alias vi='vim --servername VIM'
alias vim='vim --servername VIM'
alias grep="grep --color=auto"
alias connectvpn='sudo openvpn /etc/openvpn/server.ovpn'
alias wireup='sudo wg-quick up wg0-client'
alias wiredown='sudo wg-quick down wg0-client'
alias dotfiles="(cd $dotfilesLocation && vim -c NERDTree)"
alias ffs='sudo $(fc -ln -1)'

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
