#!/bin/bash
#Dropbox Status outputs
#Dropbox isn't enabled : "Dropbox"
#Dropbox is starting: "Starting..."
#Dropbox is Syncing: "Syncing ..."
#Dropbox is running: "Up to date..."
STATUS="$(echo `dropbox-cli status`)"
DROPBOX_ICON=""
if [[ $STATUS = \Syncing* ]]; then
  echo "$DROPBOX_ICON $(echo $STATUS | awk '{print $1}')"
else
  echo "$DROPBOX_ICON $STATUS"
fi
