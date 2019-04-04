#!/usr/bin/env bash -e

splitFlac () {
  shnsplit -f "$1.cue" -o flac "$1.flac"
}
