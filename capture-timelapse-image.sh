#!/bin/bash

# Capture a single frame from the Raspberry Pi Camera.
# Specify image dimensions and compression quality then transfer to a remote
# host without ever writing to the local drive. (Saves SD card writes.)

# Use cron to run this script every minute between the hours of roughly
# 6AM and 5PM. Stills are compiled at the end of the day via the make-timelapse
# script, also triggered via cron.

thisminute=`date +%H%M`

# Save to remote host.
raspistill -w 1920 -h 1090 -q 10 -o - | ssh user@domain.com "cat - > /var/www/html/timelapse/image-$thisminute.jpg"

# Copy image
ssh user@domain.com "cp /var/www/html/timelapse/image-$thisminute.jpg /var/www/html/image.jpg"

# Save locally
#today=`date +%Y-%m-%d-%H%M%S`
#raspistill -w 1920 -h 1080 -q 15 -o /home/pi/img/img-$today.jpg
