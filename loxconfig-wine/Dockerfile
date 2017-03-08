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
FROM r.nitram.at/wine
MAINTAINER Martin Buchleitner <mabunixda@gmail.com>

ARG LOXURL=https://www.loxone.com/dede/wp-content/uploads/sites/2/2016/11/Loxone-Config-8.1.zip

WORKDIR /tmp

RUN apt-get update && apt-get install -y \
	curl ca-certificates unzip \
	--no-install-recommends \
    && fname=$(basename $LOXURL) \
	&& curl -o $fname $LOXURL  \
    && unzip $fname \
    && xname="${fname%.zip}.exe" \
    && mv $xname /usr/src/$xname \
    && rm -rf * \
	&& rm -rf /var/lib/apt/lists/* \
    && echo "#!/bin/bash\n\nwine /usr/src/$xname;  rm /usr/src/$xname; rm -f install.sh;" > /root/install.sh \
    && chmod 0755 /root/install.sh

WORKDIR /root

CMD ["bash"]
