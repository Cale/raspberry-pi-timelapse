#!/bin/bash

# Capture a single frame from the Raspberry Pi Camera.
# Specify image dimensions and compression quality then transfer to a remote
# host without ever writing to the local drive. (Saves SD card writes.)
# File is written over itself each capture.

# Save to remote host.
raspistill -w 1920 -h 1090 -q 10 -o - | ssh user@domain.com "cat - > /var/www/html/image.jpg"

# Save locally
#today=`date +%Y-%m-%d-%H%M%S`
#raspistill -w 1920 -h 1080 -q 15 -o /home/pi/img/img-$today.jpg
