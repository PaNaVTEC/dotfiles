#!/bin/sh

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

#Setup trackpoint
tpset() { xinput set-prop "TPPS/2 IBM TrackPoint" "$@"; }

tpset "Evdev Wheel Emulation" 1
tpset "Evdev Wheel Emulation Button" 2
tpset "Evdev Wheel Emulation Timeout" 200
tpset "Evdev Wheel Emulation Axes" 6 7 4 5
tpset "Device Accel Constant Deceleration" 0.95

setxkbmap -layout us -variant altgr-intl -option nodeadkeys

# When I have a full screen disable suspend
nodpms &

#hides the mouse when inactivity
#unclutter -b --timeout 30 &

#exec startkde
exec i3
