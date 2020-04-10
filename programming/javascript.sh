#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

NO_PKG_JSON="No package.json found"

alias jsProject='javascriptProject;'

createJavascriptProject () {
  TAB="  "
  mkdir -p "$1"
  cd "$1" || return
  gibo dump Node JetBrains Vim Emacs macOS Linux Windows > .gitignore
  yarn init -y
  yarn add mocha chai standard
  yarn add babel-core babel-preset-es2015 --dev
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
  yarn
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

nLastVersion() {
  npm show "$1@*" version | tail -1
}

nn () {
  if [ -e yarn.lock ]; then
    yarn $@
  else
    valid_commands=("access", "adduser", "audit", "bin", "bugs", "c", "cache", "ci", "cit", \
    "completion", "config", "create", "ddp", "dedupe", "deprecate", \
    "dist-tag", "docs", "doctor", "edit", "explore", "get", "help", \
    "help-search", "hook", "i", "init", "install", "install-test", "it", "link", \
    "list", "ln", "login", "logout", "ls", "outdated", "owner", "pack", "ping", \
    "prefix", "profile", "prune", "publish", "rb", "rebuild", "repo", "restart", \
    "root", "run", "run-script", "s", "se", "search", "set", "shrinkwrap", "star", \
    "stars", "start", "stop", "t", "team", "test", "token", "tst", "un", \
    "uninstall", "unpublish", "unstar", "up", "update", "v", "version", "view", \
    "whoami")

    if [ "" == "$1" ]; then
      npm install
    else

      local found;
      for i in "${valid_commands[@]}"
      do
        if [ "$i" == "$1" ] ; then
          found=1;
        fi
      done

      if [[ $found -eq 1 ]]; then
        npm $@
      else
        npm run $@
      fi
    fi
  fi
}
