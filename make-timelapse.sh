#!/bin/bash

# This script compiles a series of still images into a video timelapse.

# Images named with date/time of capture appended at the end are renamed into
# a sequential set. image-0001, image-0002, etc. which avconv needs to do its
# thing.

ls /var/www/html/timelapse/*.jpg| awk 'BEGIN{ a=0 }{ printf "mv %s /var/www/html/timelapse/image-%04d.jpg\n", $0, a++ }' | bash

today=`date +%m-%d-%Y`

# avconv does the actual conversion of stills to video. "0001" specifies the
# file to start with. -r is framerate. Anything more than 24 frames per
# second becomes imperceptible to the human eye and feels unnatural. libx264
# specifies the h.264 codec used to encode the video.
avconv -start_number 0001 -r 24 -i /var/www/html/timelapse/image-%4d.jpg -vcodec libx264 -vf scale=1920:1080 /var/www/html/timelapse/image-timelapse-$today.mp4

# Copy and rename video for easier access each day.
cp /var/www/html/timelapse/image-timelapse-$today.mp4 /var/www/html/timelapse/image-timelapse-today.mp4

# Delete the source image stills to save drive space.
rm /var/www/html/timelapse/*.jpg
