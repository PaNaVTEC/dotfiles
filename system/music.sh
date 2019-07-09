#!/usr/bin/env bash -e

splitFlac () {
  shnsplit -f "$1.cue" -o flac "$1.flac"
}

splitFlacSpecialCue () {
  cuebreakpoints "$1.cue" | sed s/$/0/ | shnsplit -o flac "$1.flac"
}

pathOfSong () {
  beet ls -f '$path' -- "artist:$1" "title:~$2" year- | head -n 1
}

playListOf () {
  fileName=$1
  artist=$2
  while read -r line; do
    if [ -z "$artist" ]; then
      echo "Parsing: $line"
      result=$(pathOfSong "$(echo $line | cut -d'-' -f1)" "$(echo $line | cut -d'-' -f2)")
      echo "Output: $result"
      echo "$result" >> "$fileName.m3u"
    else
      echo "Parsing: $line"
      result=$(pathOfSong "$artist" "$line")
      echo "Output: $result"
      echo "$result" >> "$fileName.m3u"
    fi
  done < "$fileName"
}

fixFiioAbsolutePaths () {
  # /storage/external_sd/Music/3 doors down/.....
  (cd /run/media/panavtec/disk && sed -i 's/\/run\/media\/panavtec\/disk/\/storage\/external_sd/g' *.m3u)
}
