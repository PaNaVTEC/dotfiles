#!/bin/bash -ex

if [[ $(pgrep X) ]]; then
  feh --bg-scale ~/Pictures/pict.png
else
  output "*" background ~/Pictures/pict.png
fi
