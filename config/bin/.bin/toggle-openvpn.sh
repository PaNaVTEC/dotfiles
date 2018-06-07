if [ $(pgrep openvpn) ]; then
  kill $(pgrep openvpn)
else
  openvpn /etc/openvpn/server.ovpn &
fi
