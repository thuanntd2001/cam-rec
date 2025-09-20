#!/bin/bash

# Specify the directory containing images
IMAGE_DIR="downloaded_images"
# Specify the output video file name
OUTPUT_VIDEO="output_video.mp4"
# Specify the frame rate (frames per second)
FRAME_RATE=3

# Navigate to the image directory
cd "$IMAGE_DIR" || exit

# Create the video from images
ffmpeg -framerate "$FRAME_RATE" -i image%04d.jpg -c:v libx264 -pix_fmt yuv420p "$OUTPUT_VIDEO"

echo "Video $OUTPUT_VIDEO created successfully!"
