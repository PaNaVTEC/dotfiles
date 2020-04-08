#!/usr/bin/env bash -e

TABLET_WIDTH=1280
TABLET_HEIGHT=850
TABLET_REFRESH_RATE=60.00
TABLET_POSITION='below'
CURRENT_MONITOR=$(xrandr | grep -Po '.+(?=\sconnected)')

startVirtualMonitor () {
  MODE="${TABLET_WIDTH}x${TABLET_HEIGHT}_${TABLET_REFRESH_RATE}"
#  GTFO=$(gtf $TABLET_WIDTH $TABLET_HEIGHT $TABLET_REFRESH_RATE | grep -oP "\".+")
#  xrandr --addmode VIRTUAL1 $MODE

  if [[ "$(xrandr | grep $MODE)" = "" ]]; then
#    xrandr --newmode "1920x1200_60.00" 108.88 1920 1360 1496 1712 1200 1025 1028 1060 -HSync +Vsync
#    xrandr --addmode VIRTUAL1 1920x1200_60.00

    xrandr --newmode "$MODE" $(gtf $TABLET_WIDTH $TABLET_HEIGHT $TABLET_REFRESH_RATE | grep -oP '(?<="\s\s).+')
    xrandr --addmode VIRTUAL1 "$MODE"
  fi

  if [ $TABLET_POSITION == 'right' ]; then
    xrandr --output VIRTUAL1 --mode $MODE --primary --right-of $CURRENT_MONITOR
  elif [ $TABLET_POSITION == 'below' ]; then
    xrandr --output VIRTUAL1 --mode $MODE --primary --below $CURRENT_MONITOR
  fi
}

startVnc () {
  RESOLUTION=$(xrandr | grep $CURRENT_MONITOR | cut -d' ' -f 3)
  CURRENT_WIDTH=$(echo $RESOLUTION | cut -d'x' -f 1)
  CURRENT_HEIGHT=$(echo $RESOLUTION | cut -d'x' -f 2)

  if [ $TABLET_POSITION == 'right' ]; then
    GEOMETRY="${TABLET_WIDTH}x${TABLET_HEIGHT}+${CURRENT_WIDTH}+0"
  elif [ $TABLET_POSITION == 'below' ]; then
    GEOMETRY="${TABLET_WIDTH}x${TABLET_HEIGHT}+0+${CURRENT_HEIGHT}"
  fi

  x11vnc -clip "$GEOMETRY" -ncache 10 -viewonly -cursor arrow -multiptr
  # x0vncserver -display $DISPLAY -passwordfile ~/.vnc/passwd -Geometry "$GEOMETRY"
}

startMonitor () {
  startVirtualMonitor
  startVnc &
}
