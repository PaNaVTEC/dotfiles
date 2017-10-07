#!/bin/bash -e

alias yarn='yarn --emoji $_'
alias ya='yarn --emoji $_'
alias jsProject='javascriptProject;'
javascriptProject () {
  TAB="  "
  mkdir -p "$1"
  cd "$1" || return
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
  if [ -e package.json ]; then
    sudo n "$(jq .engines.node -r package.json)"
  else
    echo "No package.json found"
  fi
}

nScripts() {
  if [ -e package.json ]; then
    jq .scripts package.json
  else
    echo "No package.json found"
  fi
}

nDependencies() {
  if [ -e package.json ]; then
    jq .dependencies package.json
  else
    echo "No package.json found"
  fi
}

nDevDependencies() {
  if [ -e package.json ]; then
    jq .devDependencies package.json
  else
    echo "No package.json found"
  fi
}

nb () {
  "$(npm bin)/$1"
}

nBumpMinor () {
  local version=$(jq -r '.version' package.json)
  local newVersion=$(echo "$version" | awk -F. '{$NF = $NF + 1;} 1' | sed 's/ /./g')
  jq -r ".version |= \"$newVersion\"" package.json > .newPackage.json
  rm package.json
  mv .newPackage.json package.json
}
