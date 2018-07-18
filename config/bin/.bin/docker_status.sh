#!/bin/bash

DOCKERD=$(pidof dockerd)
if [[ $DOCKERD = "" ]]; then
  echo "x"
else
  N_IMAGES=$(docker ps | grep -vc IMAGE)
  echo "$N_IMAGES"
fi
