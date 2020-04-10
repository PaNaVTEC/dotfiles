#!/usr/bin/env bash

alias ghc='stack exec ghc --'
alias ghci='stack exec ghci --'
alias si='stack install'
alias sbf='stack build --fast'
alias sbfw='stack build --fast --ghc-options="-Wwarn"'

hid () {
  ghcid --command "stack ghci --ghc-options='-O0' --ghci-options='-fobject-code -O0' $2 $1"
}

hidskip () {
  hid $1 --skip-intermediate-deps
}

hi () {
  stack ghci --ghc-options='-O0' --ghci-options='-fobject-code -O0' $1
}

hiskip () {
  hi $1 --skip-intermediate-deps
}

debugTemplateHaskell () {
  read -p "If you don't 'stack clean' it will not work, do stack clean?" -n 1 -r
  echo ""
  if [[ $REPLY =~ ^[yY]$ ]]; then
    sbf --ghc-options="-fbyte-code -O0 -Wwarn -ddump-splices -ddump-to-file"
  fi
}

createProjectHaskell () {
  local projectDirectory=$1
  local name=''
  local email=''
  local username=''
  name=$(cat ~/.gitconfig | grep name | awk -F '= ' '{print $2}')
  email=$(cat ~/.gitconfig | grep email | awk -F '= ' '{print $2}')
  username=$(echo "$email" | awk -F '@' '{print $1}')

  stack \
    new "$projectDirectory" hspec \
    -p "name:$projectDirectory" \
    -p "author-email:$email" \
    -p "author-name:$name" \
    -p "category:katas" \
    -p "copyright:Apache2" \
    -p "github-username:$username"

  (cd "$projectDirectory" && \
    gibo dump Haskell JetBrains Vim Emacs macOS Linux Windows > .gitignore)
}

createScriptHaskell () {
  cat >$1.hs <<EOL
#!/usr/bin/env stack
-- stack --resolver lts-10.0 script
<code here>
EOL
}
