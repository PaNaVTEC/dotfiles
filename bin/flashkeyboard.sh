#!/bin/bash
sudo dfu-programmer atmega32u2 erase
sudo dfu-programmer atmega32u2 flash $1
sudo dfu-programmer atmega32u2 start
