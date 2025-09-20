 #!/bin/bash

# Specify the URL of the image
IMAGE_URL="http://192.168.100.57/capture"


# Counter for naming downloaded images

MAX=30
FRAME_RATE=5
RATE=$(echo "scale=2; 1 / $FRAME_RATE" | bc)

#start loop
while true ; do
	COUNTER=1
	DATE=$(date +%Y%m%d_%H%M%S)
	# Specify the output directory to save images
	OUTPUT_DIR="images_$DATE"
	# Create the output directory if it doesn't exist
	mkdir -p "$OUTPUT_DIR"
	#  loop to download the image every 0.3 seconds
	while [ $COUNTER -lt $MAX ] ; do
	    # Create a filename based on the counter
	    FILENAME="$OUTPUT_DIR/image$(printf "%04d" $COUNTER).jpg"
	
	    # Download the image
	    curl -o "$FILENAME" "$IMAGE_URL"
	
	    # Increment the counter
	    COUNTER=$((COUNTER + 1))
	
	    # Wait for x seconds
	    sleep $RATE
	done
	
	
	IMAGE_DIR=$OUTPUT_DIR
	# Specify the output video file name
	OUTPUT_VIDEO="video_$DATE"
	# Specify the frame rate (frames per second)
	
	
	# Create the video from images
	ffmpeg -framerate "$FRAME_RATE" -i "$IMAGE_DIR/image%04d.jpg" -c:v libx264 -pix_fmt yuv420p -f mp4 "$OUTPUT_VIDEO"
		
	if [ $? -ne 0 ]; then
	    echo "Error: ffmpeg command failed. Check error_log.txt for details."
	else
	    echo "Success: Video created successfully."
		rm -rf  $IMAGE_DIR
	fi
done
