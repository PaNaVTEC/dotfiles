#!/bin/bash -ex

BACKGROUND="$HOME/Pictures/pict.png"

if [[ $(pidof X) ]]; then
  feh --bg-scale "$BACKGROUND"
else
  output "*" background "$BACKGROUND"
fi
