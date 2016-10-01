#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

if [ -d ~/.after_startx ] ; then
 for f in ~/.after_startx/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

exec i3
