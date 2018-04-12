#!/bin/bash -ex

if [[ $(pgrep Xorg) ]]; then
  feh --bg-scale ~/Pictures/pict.png
else
  output "*" background ~/Pictures/pict.png
fi
