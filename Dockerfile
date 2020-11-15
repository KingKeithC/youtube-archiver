FROM python:3-alpine

ENV YTAR_DOWNLOAD_TMP_PATH="/tmp/ytar/"
ENV YTAR_DOWNLOAD_BATCH_PATH="/batchfile"
ENV YTAR_DOWNLOAD_ARCHIVE_PATH="/ytdl-archive"
ENV YTAR_INSTALL_BASE_PATH="/opt/ytar"
ENV YTAR_DOWNLOAD_TEMP_PATH="/downloads"

WORKDIR "$YTAR_INSTALL_BASE_PATH"

COPY . .

RUN ls -l && \
		pip install --no-cache-dir youtube_dl && \
		apk add --no-cache rclone bash

VOLUME [ "$YTAR_DOWNLOAD_BATCH_PATH", "$YTAR_DOWNLOAD_ARCHIVE_PATH" ]

ENTRYPOINT ./archiver.sh
