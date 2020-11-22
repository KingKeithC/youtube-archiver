#! /bin/bash

# Fail if no argument was passed to the script
if [[ $# -ne 1 ]]; then
	echo "Usage: $0 <path_to_file>"
	exit 1
fi

SRCPATH="$YTAR_DOWNLOADS_PATH/$1"
DESTPATH="main:/$YTAR_S3_BUCKET_NAME/$SRCPATH"

# Clone the file to to main backend, using the
echo "Copying $SRCPATH to $DESTPATH ..."
rclone --config "$YTAR_INSTALL_BASE_PATH/rclone.conf" copy "$FILEPATH" "$DESTPATH"
