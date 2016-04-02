#!/bin/bash

#Alright, so this should automatically convert a given video into a gif called optimized_output.gif
# See here for explanation: https://github.com/lelandbatey/configDebDev/blob/master/helpFiles.md#converting-videos-to-animated-gifs

ffmpeg -i $1 out%04d.gif # Extracts each frame of the video as a single gif
convert -delay 4 out*.gif anim.gif # Combines all the frames into one very nicely animated gif.
convert -layers Optimize anim.gif $1.gif # Optimizes the gif using imagemagick

# vvvvv Cleans up the leftovers
rm out*
rm anim.gif
