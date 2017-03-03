#!/bin/bash

docker run --rm -it \
	-v /etc/localtime:/etc/localtime:ro \
	--cpuset-cpus 0 \
	-v /tmp/.X11-unix:/tmp/.X11-unix  \
	-e DISPLAY=unix$DISPLAY \
	--device /dev/snd:/dev/snd \
	--name loxconfig-wine \
	loxconfig-wine \
	bash