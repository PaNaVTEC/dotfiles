#!/bin/bash
intern=LVDS-1
extern=DP-1

if xrandr | grep "$extern disconnected"; then
  xrandr --output "$extern" --off
  xrandr --output "$intern" --auto --primary
else
  xrandr --output "$intern" --off
  xrandr --output "$extern" --auto --primary
fi

set-wallpaper.sh
