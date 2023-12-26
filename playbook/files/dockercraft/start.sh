#!/bin/bash

docker run -d -t -i \
	--name dockercraft \
	-p 25565:25565 \
	-v /var/run/docker.sock:/var/run/docker.sock \
	-v ./config/settings.ini:/srv/Server/settings.ini \
	docker/dockercraft
