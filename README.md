# Usage

1. Create a batchfile listing playlists to archive. Each playlist should be on its own line, like so:
	```
	$ cat batch
	https://www.youtube.com/playlist?list=PLFD1682F2801E7ADF
	https://www.youtube.com/playlist?list=PLaAVDbMg_XArcet5lwcRo12Fh9JrGKydh
	```

2. Run the archiver, passing the batchfile in as a volume at `/batchfile`, and optionally an archivefile to allow download resuming in the future:
	```
	docker run --rm -v `pwd`/archive:/archivefile -v `pwd`/batch:/batchfile github.com/kingkeithc/youtube-archiver
	```
