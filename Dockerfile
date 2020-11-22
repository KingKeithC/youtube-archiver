FROM python:3-alpine

ENV YTAR_DOWNLOADS_PATH="/downloads"
ENV YTAR_ARCHIVE_PATH="/archive"
ENV YTAR_INSTALL_BASE_PATH="/opt/ytar"
ENV YTAR_S3_BUCKET_NAME=""

WORKDIR "$YTAR_INSTALL_BASE_PATH"

COPY . .

RUN ls -l && \
		pip install --no-cache-dir youtube_dl && \
		apk add --no-cache rclone bash

VOLUME [ "$YTAR_ARCHIVE_PATH" ]

ENTRYPOINT ["./archiver.sh"]
