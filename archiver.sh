#! /bin/bash

# Exit immediately on errors
set -o errexit

# runcmd echoes a command to terminal before evaling it
function runcmd {
	# Remove tabs from the command before echoing it for better readability
	echo "Executing command: '$(echo $@ | tr -d \\t)'..."
	eval "$@"
}

# errexit prints an error message, then exits the script
function errexit {
	echo "$@"
	exit 1
}

# Set required variables
YTAR_DOWNLOAD_BATCH_PATH="${YTAR_DOWNLOAD_BATCH_PATH:-/batchfile}"
YTAR_DOWNLOAD_ARCHIVE_PATH="${YTAR_DOWNLOAD_ARCHIVE_PATH:-/archivefile}"
YTAR_DOWNLOAD_TEMP_PATH="${YTAR_DOWNLOAD_TEMP_PATH:-/downloads}"

YTAR_YTDL_CONFIG_PATH="${YTAR_YTDL_CONFIG_PATH:-$YTAR_INSTALL_BASE_PATH/ytdl.conf}"
YTAR_YTDL_CMD_BASE="python -m youtube_dl --config-location $YTAR_YTDL_CONFIG_PATH"

YTAR_RCLONE_CONFIG_PATH="${YTAR_RCLONE_CONFIG_PATH:-$YTAR_INSTALL_BASE_PATH/rclone.conf}"
YTAR_RCLONE_CMD_BASE="rclone --config $YTAR_RCLONE_CONFIG_PATH"

mkdir "$YTAR_DOWNLOAD_TEMP_PATH"

# Check that files are in place where needed
[[ ! -f "$YTAR_DOWNLOAD_BATCH_PATH" ]] 	&& errexit "The path '$YTAR_DOWNLOAD_BATCH_PATH' does not exist!"
[[ ! -f "$YTAR_DOWNLOAD_ARCHIVE_PATH" ]] && touch $YTAR_DOWNLOAD_ARCHIVE_PATH

# Check that some required variables are set
[[ -z "$AWS_ACCESS_KEY_ID" ]] 		&& errexit "The variable AWS_ACCESS_KEY_ID is missing or not set."
[[ -z "$AWS_SECRET_ACCESS_KEY" ]] && errexit "The variable AWS_SECRET_ACCESS_KEY is missing or not set."

# Print variables when debugging
[[ -n "$YTAR_DEBUG" ]] && set | grep YTAR

echo "Starting..."
runcmd "$YTAR_CMD_BASE \
	--batch-file $YTAR_DOWNLOAD_BATCH_PATH \
	--output '$YTAR_DOWNLOAD_TEMP_PATH/channels/%(channel_id)s/playlists/%(playlist_id)s/%(playlist_index)s_%(release_date)s_%(id)s_%(title)s.%(ext)s' \
	--download-archive $YTAR_DOWNLOAD_ARCHIVE_PATH \
	$@"
