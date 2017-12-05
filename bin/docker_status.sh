if [[ $(pgrep dockerd) == "" ]]; then
  echo "x"
else
  N_IMAGES=$(docker ps | grep -vc IMAGE)
  echo "$N_IMAGES"
fi
