![Standard Build](https://github.com/KingKeithC/youtube-archiver/workflows/Standard%20On-Push%20Build/badge.svg?branch=master)

A docker image for archiving a set of youtube videos to Amazon S3 using rclone.

### Links to related projects:
- [Youtube DL](https://github.com/ytdl-org/youtube-dl/)
- [RClone](https://rclone.org/)

# Usage
```sh
docker run [DOCKER_OPT...] github.com/kingkeithc/youtube-archiver YOUTUBE_PLAYLIST [YOUTUBE_PLAYLIST...]
```
|Option|Usage|
|------|-----|
|DOCKER_OPT|Any valid option for `docker` or the `docker run` subcommand.|
|YOUTUBE_PLAYLIST|The URL to a YouTube playlist of videos to archive.|

## Quick Start
Run the archiver, using `/archive` to store the list of already downloaded files for use with resuming:
```sh
docker run --rm -it \
-v `pwd`/archive:/archive/ \
-e YTAR_S3_BUCKET_NAME="replaceme" \
-e AWS_ACCESS_KEY_ID="replaceme" \
-e AWS_SECRET_ACCESS_KEY="replaceme" \
github.com/kingkeithc/youtube-archiver \
https://www.youtube.com/playlist?list=PLFD1682F2801E7ADF \
https://www.youtube.com/playlist?list=PLaAVDbMg_XArcet5lwcRo12Fh9JrGKydh
```

## Environment Variables
The following variables can be set with this program. Only `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` need to be set, however you can change the other ones if too if you wish.

|Name|Usage|Default|
|----|-----|-------|
|AWS_ACCESS_KEY_ID|(*Required*) The Key to use with rclone for accessing AWS S3 Glacier||
|AWS_SECRET_ACCESS_KEY|(*Required*) The secret key corresponding to AWS_ACCESS_KEY_ID||
|YTAR_S3_BUCKET_NAME|(*Required*) The S3 bucket in which to archive the downloaded videos.||
|YTAR_DOWNLOADS_PATH|The directory where the videos will be downloaded. Mount a volume here for persistence.|`/downloads`|
|YTAR_ARCHIVE_PATH|The directory where the `archivefile` will be placed. Mount a volume here so videos won't be redownloaded again if the container restarts.|`/archive`|
|YTAR_INSTALL_BASE_PATH|The path where the YouTube Archiver is installed. You shouldn't need to change this.|`/opt/ytar`|
|YTAR_YTDL_CONFIG_PATH|The path to the file to configure youtube-dl. Override this if you want to use a separate config.|`$YTAR_INSTALL_BASE_PATH/ytdl.conf`|
|YTAR_RCLONE_CONFIG_PATH|The path to the file to configure rclone. Override this if you want to use a separate config.|`$YTAR_INSTALL_BASE_PATH/rclone.conf`|
