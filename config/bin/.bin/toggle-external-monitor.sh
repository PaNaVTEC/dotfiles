#!/usr/bin/env bash

intern=eDP1
extern=HDMI1

if xrandr | grep "$extern disconnected"; then
  xrandr --output "$extern" --off
  xrandr --output "$intern" --auto --primary
else
  xrandr --output "$intern" --off
  xrandr --output "$extern" --auto --primary
fi

set-wallpaper.sh
