STATUS="$(pgrep openvpn)"

if [ "$STATUS" ]; then
  echo ' ✓'
else
  echo ' x'
fi

