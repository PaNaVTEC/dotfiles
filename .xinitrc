#!/bin/sh

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

#setxkbmap -layout us -variant altgr-intl -option nodeadkeys

# When I have a full screen disable suspend
nodpms & 

#hides the mouse when inactivity
unclutter -b --timeout 30 &

# Launch desktop environment
exec i3
