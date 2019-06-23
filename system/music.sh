#!/usr/bin/env bash -e

splitFlac () {
  shnsplit -f "$1.cue" -o flac "$1.flac"
}

splitFlacSpecialCue () {
  cuebreakpoints "$1.cue" | sed s/$/0/ | shnsplit -o flac "$1.flac"
}

pathOfSong () {
  beet ls -f '$path' -- "artist:$1" "title:~$2" | head -n 1
}

playListOf () {
  while read -r line; do
    echo "Song: $line"
    result=$(pathOfSong "$1" "$line")
    echo "Output: $result"
    echo "$result" >> "$2.m3u"
  done < "$2"
}

fixFiioAbsolutePaths () {
  # /storage/external_sd/Music/3 doors down/.....
  (cd /run/media/panavtec/disk && sed -i 's/\/run\/media\/panavtec\/disk/\/storage\/external_sd/g' *.m3u)
}
