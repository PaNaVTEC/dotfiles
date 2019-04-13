#!/bin/bash

alias tls='tmux ls'

tn () {
  tmux new-session -t "$1"
}

trm () {
  tmux kill-session -t "$1"
}

alias trmf='tmux kill-session -a'
