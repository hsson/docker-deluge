UI_PORT=8112
DATA_FOLDER=/some/path/to/download/stuff

build:
	docker build -t deluge .

first-launch:
	docker run \
		--name deluge \
		-v $(DATA_FOLDER):/data \
		-p $(UI_PORT):$(UI_PORT)  \
		-t deluge &
start:
	docker start deluge

stop:
	docker stop deluge

restart:
	docker stop deluge && docker start deluge

clean:
	docker stop deluge && docker rm deluge