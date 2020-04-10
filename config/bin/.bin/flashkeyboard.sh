#!/usr/bin/env bash

S60X='atmega32u4'
FILCO='atmega32u2'
sudo dfu-programmer $S60X erase
sudo dfu-programmer $S60X flash "$1"
sudo dfu-programmer $S60X start
