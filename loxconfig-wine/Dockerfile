#
# RUN loxone Configuration in docker container
#
# run the lox-install.sh and run the last bash command
# after the installation run the following before exiting the first container:
# docker commit loxconfig-install loxconfig-wine:8.1
#
# Then you can run the container with the following command:
# docker run --rm -it \
#		-v /etc/localtime:/etc/localtime:ro \
#		--cpuset-cpus 0 \
#		-v /tmp/.X11-unix:/tmp/.X11-unix  \
#		-e DISPLAY=unix$DISPLAY \
#		--device /dev/snd:/dev/snd \
#		--name loxconfig-wine-8.1 \
#		loxconfig-wine:8.1 \
#		wine "C:\Program Files (x86)\Loxone\LoxoneConfig\LoxoneConfig.exe"
#
FROM wine
MAINTAINER Martin Buchleitner <mabunixda@gmail.com>

WORKDIR /tmp

RUN apt-get update && apt-get install -y \
	curl ca-certificates unzip \
	--no-install-recommends \
	&& curl -o loxone-config.zip https://www.loxone.com/dede/wp-content/uploads/sites/2/2016/11/Loxone-Config-8.1.zip \
    && unzip loxone-config.zip \
    && mv Loxone-Config-8.1.exe /usr/src/Loxone-Config-8.1.exe \
    && rm -rf * \
	&& rm -rf /var/lib/apt/lists/* \
    && echo "wine /usr/src/Loxone-Config-8.1.exe" > /root/.bash_history

WORKDIR /root


CMD ["bash"]
