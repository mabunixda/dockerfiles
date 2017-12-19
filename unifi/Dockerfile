FROM debian:jessie
LABEL maintainer "Martin Buchleitner <mabunixda@gmail.com>"

ENV DEBIAN_FRONTEND noninteractive

ADD http://dl.ubnt.com/unifi/5.6.26/unifi_sysvinit_all.deb /usr/src/unify_sysvinit_all.deb
# Install unify
RUN apt-get update -q \
	&& apt-get install -y gnupg2 dirmngr --no-install-recommends  \
	&& apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6 \
	&& echo "deb http://repo.mongodb.org/apt/debian jessie/mongodb-org/3.4 main" > /etc/apt/sources.list.d/mongodb-org-3.4.list \
	&& apt-get update -q \
	&& apt-get install -y mongodb-org \
	&& dpkg --force-depends  -i '/usr/src/unify_sysvinit_all.deb' \
	&& apt-get install -qyf \
	&& rm -rf /var/lib/apt/lists/* \
	&& rm -rf /usr/src/*.deb

EXPOSE 6789/tcp 8080/tcp 8443/tcp 8880/tcp 8843/tcp 3478/udp

WORKDIR /usr/lib/unifi

ENTRYPOINT [ "/usr/bin/java", "-Djava.awt.headless=true", "-Dfile.encoding=UTF-8", "-Xmx256M", "-jar", "/usr/lib/unifi/lib/ace.jar", "start" ]
