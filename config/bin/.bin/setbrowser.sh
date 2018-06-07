#!/bin/bash
NEWBROWSER=inox.desktop

xdg-mime default $NEWBROWSER x-scheme-handler/http
xdg-mime default $NEWBROWSER x-scheme-handler/https
xdg-mime default $NEWBROWSER text/html
xdg-settings set default-web-browser $NEWBROWSER
