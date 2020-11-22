#! /bin/bash

set -o errexit
set -o nounset

# Fail if no argument was passed to the script
if [[ $# -ne 1 ]]; then
	echo "Usage: $0 <path_to_file>"
	exit 1
fi

SRCPATH="$(dirname $1)"
DESTPATH="main:$YTAR_S3_BUCKET_NAME$SRCPATH"

# Clone the file to to main backend, using the
echo "Using rclone to copy '$SRCPATH' to '$DESTPATH' ..."
rclone --config "$YTAR_INSTALL_BASE_PATH/rclone.conf" --verbose --progress copy "$SRCPATH" "$DESTPATH"
echo "Copy complete"
