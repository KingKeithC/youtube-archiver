#! /bin/bash

# Exit immediately on errors
set -o errexit

# errexit prints an error message, then exits the script
function errexit {
	echo "$@"
	exit 1
}

# Check that some required variables are set
[[ -z "$YTAR_DOWNLOADS_PATH" ]]			&& errexit "The variable YTAR_DOWNLOADS_PATH is missing or not set."
[[ -z "$YTAR_ARCHIVE_PATH" ]]				&& errexit "The variable YTAR_ARCHIVE_PATH is missing or not set."
[[ -z "$YTAR_INSTALL_BASE_PATH" ]]	&& errexit "The variable YTAR_INSTALL_BASE_PATH is missing or not set."
[[ -z "$YTAR_S3_BUCKET_NAME" ]]			&& errexit "The variable YTAR_S3_BUCKET_NAME is missing or not set."
[[ -z "$AWS_ACCESS_KEY_ID" ]]				&& errexit "The variable AWS_ACCESS_KEY_ID is missing or not set."
[[ -z "$AWS_SECRET_ACCESS_KEY" ]]		&& errexit "The variable AWS_SECRET_ACCESS_KEY is missing or not set."

# Set some local variables
YTAR_YTDL_CONFIG_PATH="${YTAR_YTDL_CONFIG_PATH:-$YTAR_INSTALL_BASE_PATH/ytdl.conf}"
YTAR_RCLONE_CONFIG_PATH="${YTAR_RCLONE_CONFIG_PATH:-$YTAR_INSTALL_BASE_PATH/rclone.conf}"

# Print variables when debugging
[[ -n "$YTAR_DEBUG" ]] && set | grep YTAR

echo "Arguments: $*"
echo "Starting Download from YouTube..."
# In our case, we intend to expand the remaining arguments, so SC2048 can be skipped for the next command.
# shellcheck disable=SC2048
python -m youtube_dl \
 --config-location "$YTAR_YTDL_CONFIG_PATH" \
 --download-archive "$YTAR_ARCHIVE_PATH/archivefile" \
 --output "$YTAR_DOWNLOAD_TEMP_PATH/channels/%(channel_id)s/playlists/%(playlist_id)s/%(playlist_index)s_%(release_date)s_%(id)s_%(title)s.%(ext)s" \
 --exec "$YTAR_INSTALL_BASE_PATH/on_download.sh {}" \
 $*
