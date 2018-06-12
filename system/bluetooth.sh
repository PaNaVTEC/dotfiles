#!/usr/bin/env bash

bt_poweron() {
  echo -e 'power on\nquit' | bluetoothctl
}

bt_poweroff() {
  echo -e 'power off\nquit' | bluetoothctl
}
