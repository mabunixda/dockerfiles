FROM debian:stretch
LABEL maintainer "Martin Buchleitner <mabunixda@gmail.com>"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -q \
	&& apt-get install -y gnupg2 dirmngr --no-install-recommends  \
	&& apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6 \
	# && echo "deb http://repo.mongodb.org/apt/debian stretch/mongodb-org/3.4 main" > /etc/apt/sources.list.d/mongodb-org-3.4.list \
        && echo 'deb http://www.ubnt.com/downloads/unifi/debian stable ubiquiti' >  /etc/apt/sources.list.d/100-ubnt-unifi.list \
	&& apt-get update -q \
	&& apt-get install -y --allow-unauthenticated mongodb \
        && apt-get install -y --allow-unauthenticated unifi \
	&& rm -rf /var/lib/apt/lists/* 

EXPOSE 6789/tcp 8080/tcp 8443/tcp 8880/tcp 8843/tcp 3478/udp

WORKDIR /usr/lib/unifi

ENTRYPOINT [ "/usr/bin/java", "-Djava.awt.headless=true", "-Dfile.encoding=UTF-8", "-Xmx256M", "-jar", "/usr/lib/unifi/lib/ace.jar", "start" ]
