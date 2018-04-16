#!/usr/bin/env bash

wi_connect() {
  nmcli device wifi connect "$1" password "$2"
}

wi_connect_hidden() {
  nmcli device wifi connect "$1" password "$2" hidden yes
}

wi_scan() {
  nmcli device wifi
}

wi_off() {
  nmcli radio wifi off
}

wi_on() {
  nmcli radio wifi on
}
