#!/bin/bash
#Dropbox Status outputs
#Dropbox isn't enabled : "Dropbox"
#Dropbox is starting: "Starting..."
#Dropbox is Syncing: "Syncing ..."
#Dropbox is running: "Up to date..."
STATUS="$(echo `dropbox-cli status`)"
DROPBOX_ICON=""
if [[ $STATUS = "Up to date" ]]; then
  echo "$DROPBOX_ICON ✓"
elif [[ $STATUS = \Syncing* ]]; then
  echo "$DROPBOX_ICON "
else
  echo "$DROPBOX_ICON x"
fi
