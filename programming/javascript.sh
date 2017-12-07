#!/bin/bash -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$DIR/yarn-completion.bash"

NO_PKG_JSON="No package.json found"

alias yarn='yarn --emoji $_'
alias ya='yarn --emoji $_'
alias jsProject='javascriptProject;'

projectCreateJavascript () {
  TAB="  "
  mkdir -p "$1"
  cd "$1" || return
  gibo Node JetBrains Vim Emacs macOS Linux Windows > .gitignore
  ya init -y
  ya add mocha chai standard
  ya add babel-core babel-preset-es2015 --dev
  cp "$DOTFILES_LOCATION/config/vim/tern-project" ./.tern-project
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

jsonPrettyPrintNonStrict () {
  cat $1 | node <<< "var o = $(cat); console.log(JSON.stringify(o, null, 4));"
}

nUse() {
  [ -e package.json ] && sudo n "$(jq .engines.node -r package.json)" || echo "$NO_PKG_JSON"
}

nScripts() {
  [ -e package.json ] && jq .scripts package.json || echo "$NO_PKG_JSON"
}

nDependencies() {
  [ -e package.json ] && jq .dependencies package.json || echo "$NO_PKG_JSON"
}

nDevDependencies() {
  [ -e package.json ] && jq .devDependencies package.json || echo "$NO_PKG_JSON"
}

nb () {
  "$(npm bin)/$1"
}

nBumpMinor () {
  local version=''
  local newVersion=''
  version=$(jq -r '.version' package.json)
  newVersion=$(echo "$version" | awk -F. '{$NF = $NF + 1;} 1' | sed 's/ /./g')
  jq -r ".version |= \"$newVersion\"" package.json > .newPackage.json
  rm package.json
  mv .newPackage.json package.json
}
