#!/bin/bash -e

alias ghc='stack exec ghc --'
alias ghci='stack exec ghci --'

createHaskellProject () {
  local projectDirectory=$1
  stack new "$projectDirectory"
}
