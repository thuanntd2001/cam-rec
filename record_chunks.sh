#!/bin/bash

while true; do
    # Get the current date in YYYY-MM-DD format
    current_date=$(date +%Y-%m-%d)
    cd /home/thuannguyen/Downloads/svl
    # Create a directory for the current date if it doesn't exist
    mkdir -p "$current_date"
    
    # Capture the screen and save the video in the date folder
    ffmpeg -y -f x11grab -video_size 480x320 -i :0.0+400,329 -c:v libx264 -t 600 "/home/thuannguyen/Downloads/svl/$current_date/$(date +%H-%M-%S).mp4"
done

