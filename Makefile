UI_PORT=8112
DATA_FOLDER=/some/data/dir/
VPN_USER=username
VPN_PASS=password

build:
	docker build -t deluge \
	--build-arg VPN_USER=${VPN_USER} \
	--build-arg VPN_PASS=${VPN_PASS} \
	.

first-launch: build
	docker run \
		--name deluge \
		-v $(DATA_FOLDER):/data \
		-p $(UI_PORT):$(UI_PORT)  \
		-p 1194:1194 \
		-p 1195:1195 \
		--dns 8.8.8.8 \
		--dns 8.8.4.4 \
		--cap-add=NET_ADMIN \
		--device=/dev/net/tun \
		--sysctl net.ipv6.conf.all.disable_ipv6=0 \
		--privileged \
		-t -d deluge
start:
	docker start deluge

stop:
	docker stop deluge

restart: stop start

clean: stop
	docker rm deluge

attach:
	docker exec -i -t deluge /bin/bash