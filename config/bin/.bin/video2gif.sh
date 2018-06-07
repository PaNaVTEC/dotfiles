#!/bin/bash
ffmpeg -i "$1" -vf scale=360:-1 "$1.gif"
