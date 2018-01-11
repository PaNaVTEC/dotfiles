#!/bin/bash -e

alias ghc='stack exec ghc --'
alias ghci='stack exec ghci --'
alias si='stack install'

createProjectHaskell () {
  local projectDirectory=$1
  local name=''
  local email=''
  local username=''
  name=$(cat ~/.gitconfig | grep name | awk -F '=' '{print $2}')
  email=$(cat ~/.gitconfig | grep email | awk -F '=' '{print $2}')
  username=$(echo "$email" | awk -F '@' '{print $1}')

  stack new "$projectDirectory" hspec \
    -p "author-email:$email"\
    -p "author-name:$name" \
    -p "category:katas" \
    -p "copyright:Apache2" \
    -p "github-username:$username"

  (cd "$projectDirectory" && \
    gibo Haskell JetBrains Vim Emacs macOS Linux Windows > .gitignore)
}

createScriptHaskell () {
  cat >$1.hs <<EOL
#!/usr/bin/env stack
-- stack --resolver lts-10.0 script
<code here>
EOL
}
