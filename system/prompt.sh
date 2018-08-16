#!/usr/bin/env bash

export PROMPT_DIRTRIM=2
powerline-daemon -q
POWERLINE_COMMAND=$HOME/.local/bin/powerline-hs
POWERLINE_CONFIG_COMMAND=/bin/true
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. "$SITE_PACKAGES/powerline/bindings/bash/powerline.sh"
