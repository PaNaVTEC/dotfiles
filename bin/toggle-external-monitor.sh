#!/bin/bash
intern=LVDS-1
extern=DP-1

if xrandr | grep "$extern disconnected"; then
    xrandr --output "$extern" --off
    xrandr --output "$intern" --auto
else
    xrandr --output "$intern" --off
    xrandr --output "$extern" --auto
fi

~/dotfiles/config/polybar/launch.sh
set-wallpaper.sh
