#! /bin/bash

function runcmd {
	echo "Executing command: '$@'..."
	eval "$@"
}

function errexit {
	echo "$@"
	exit 1
}

YTAR_DOWNLOAD_BATCH_PATH="${YTAR_DOWNLOAD_BATCH_PATH:-/batchfile}"
YTAR_DOWNLOAD_ARCHIVE_PATH="${YTAR_DOWNLOAD_ARCHIVE_PATH:-/archivefile}"
YTAR_DOWNLOAD_TEMP_PATH="${YTAR_DOWNLOAD_TEMP_PATH:-/downloads}"
YTAR_YTDL_CONFIG_PATH="${YTAR_CONFIG_PATH:-$YTAR_INSTALL_BASE_PATH/ytdl.conf}"
YTAR_CMD_BASE="python -m youtube_dl --config-location $YTAR_YTDL_CONFIG_PATH"

mkdir "$YTAR_DOWNLOAD_TEMP_PATH"

[[ ! -f "$YTAR_DOWNLOAD_BATCH_PATH" ]] 	&& errexit "The path '$YTAR_DOWNLOAD_BATCH_PATH' does not exist!"
[[ ! -f "$YTAR_DOWNLOAD_ARCHIVE_PATH" ]] && errexit "The path '$YTAR_DOWNLOAD_ARCHIVE_PATH' does not exist!"

# Debug
[[ -n "$YTAR_DEBUG" ]] && set | grep YTAR

echo "Starting..."
runcmd "$YTAR_CMD_BASE \
				--batch-file $YTAR_DOWNLOAD_BATCH_PATH \
				--output '$YTAR_DOWNLOAD_TEMP_PATH/channels/%(channel_id)s/playlists/%(playlist_id)s/%(playlist_index)s_%(id)s_%(title)s_%(timestamp)s.%(ext)s' \
				--download-archive $YTAR_DOWNLOAD_ARCHIVE_PATH \
				$@"
