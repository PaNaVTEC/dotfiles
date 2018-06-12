#!/usr/bin/env bash

bt_poweron() {
  echo -e 'power on\nquit' | bluetoothctl
}

bt_poweroff() {
  echo -e 'power off\nquit' | bluetoothctl
}

bt_connect() {
  rfkill unblock bluetooth
  sleep 1
  echo -e "connect $1\nquit" | bluetoothctl
}
