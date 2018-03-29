OUTPUTS=$(swaymsg -t get_outputs)
OUTPUTS_COUNT=$(echo "$OUTPUTS" | jq 'length')
BG="$HOME/Pictures/pict.png"

if [ "$OUTPUTS_COUNT" = '1' ]; then
  WIDTH=$(echo "$OUTPUTS" | jq '.[] | .rect.width')
  HEIGHT=$(echo "$OUTPUTS" | jq '.[] | .rect.height')
  NAME=$(echo "$OUTPUTS" | jq '.[] | .name')
  swaymsg output "$NAME" pos 0 0 res "${WIDTH}x${HEIGHT}" bg "$BG" stretch
else
  swaymsg output DP-1 pos 0 0 res 3440x1440 bg "$BG" stretch primary
  swaymsg output LVDS-1 disable
fi
