dotfilesLocation=~/dotfiles
alias ls='ls --color=auto'
alias ll='exa'
alias la='ll'
alias exa='exa -bghlaU --git --group-directories-first'
alias ccat='pygmentize -g'
alias ccatl='pygmentize -g -O style=colorful,linenos=1'
alias y='yaourt'
alias ys='yaourt -Ss'
alias yi='yaourt -S'
alias yin='yi --noconfirm'
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
alias dotfiles='(cd "$dotfilesLocation" && vim -c NERDTree)'
alias ffs='sudo $(fc -ln -1)'
alias et='emacs -nw'
alias ew='emacs'
alias e='emacs'

alias yu='systemUpdate;'
alias yun='systemUpdate "--noconfirm";'
systemUpdate () {
  echo "Updating dotfiles"
  (cd "$dotfilesLocation" && git pull)
  echo "Upgrading global Js packages"
  yarn global upgrade
  echo "Upgrading system packages"
  yaourt -Syua "$1"
}

ya () {
  yarn "$@" --emoji
}

javaProject () {
  gradle init --type java-library
  sed '$itestCompile "org.mockito:mockito-all:1.10.19"' build.gradle >> build.gradle
  gradle --refresh-dependencies
}

scalaProject () {
  projectDirectory="$1"
  mkdir -p "$projectDirectory"
  sbt new scala/hello-world.g8 --name="$projectDirectory"
  echo 'libraryDependencies += "org.scalactic" %% "scalactic" % "3.0.1"' >> "$projectDirectory/build.sbt"
  echo 'libraryDependencies += "org.scalatest" %% "scalatest" % "3.0.1" % "test"' >> "$projectDirectory/build.sbt"
  echo 'addSbtPlugin("org.scalastyle" %% "scalastyle-sbt-plugin" % "0.9.0")' >> "$projectDirectory/project/plugins.sbt"
  cd "$projectDirectory" || return
  sbt ensimeConfig
  sbt scalastyleGenerateConfig
}

alias jsProject='javascriptProject;'
javascriptProject () {
  TAB="  "
  mkdir -p "$1"
  cd "$1" || return
  ya init -y
  ya add mocha chai standard
  ya add babel-core babel-preset-es2015 --dev
  cp "$dotfilesLocation/config/vim/tern-project" ./.tern-project
  jq -r '.scripts |= . + {"start": "node src/index.js", "test": "mocha ./src/**.test.js --compilers js:babel-core/register"}' package.json > temp.json
  jq -r '.standard |= . + {}' temp.json > package.json
  jq -r '.standard.globals |= . + ["after", "afterEach", "before", "beforeEach", "describe", "context", "it"]' package.json > temp.json
  mv temp.json package.json
  mkdir -p src
  touch src/index.js
  echo -e "{\n$TAB\"presets\": [\"es2015\"]\n}" > .babelrc
  local IMPORT="import { expect } from 'chai'"
  local IT="${TAB}it('Tests something', () => {\n$TAB${TAB}expect(1).to.be.eql(1)\n$TAB})"
  local DESCRIBE="describe('A test', () => {\n$IT\n})"
  local TEST="$IMPORT\n\n$DESCRIBE"
  echo -e "$TEST" > src/intext.test.js
  ya
}

nb () {
  "$(npm bin)/$1"
}

clojureProject() {
  lein new "$1"
}

every() {
  watch -c -n "$1" "$2"
}
