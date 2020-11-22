TEST_URLS = https://www.youtube.com/playlist?list=PLFD1682F2801E7ADF https://www.youtube.com/playlist?list=PLaAVDbMg_XArcet5lwcRo12Fh9JrGKydh
DOCKER_ARGS = -e "YTAR_S3_BUCKET_NAME=${TEST_S3_BUCKET}" -e "AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}" -e "AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}"

clean :
	-docker image rm github.com/kingkeithc/youtube-archiver

build :
	docker build -t github.com/kingkeithc/youtube-archiver .

test : build
	docker run --rm -it $(DOCKER_ARGS) github.com/kingkeithc/youtube-archiver $(TEST_URLS)

debug : build
	docker run --rm -it $(DOCKER_ARGS) --entrypoint bash github.com/kingkeithc/youtube-archiver
