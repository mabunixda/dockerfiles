FROM ubuntu:16.04
LABEL maintainer "Martin Buchleitner <mabunixda@gmail.com>"

ARG VERSION=5.12.16

EXPOSE 6789/tcp 8080/tcp 8443/tcp 8880/tcp 8843/tcp 27117/tcp
EXPOSE 1900/udp 3478/udp 10001/udp

ENV DEBIAN_FRONTEND="noninteractive"
ENV BASEDIR=/usr/lib/unifi

RUN apt-get update -q \
	&& apt-get install -y curl apt-transport-https gnupg2 dirmngr wget ca-certificates --no-install-recommends  \
	&& apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6 \
	&& apt-key adv --keyserver keyserver.ubuntu.com --recv 06E85760C0A52C50  \
	&& echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.4.list \
	&& apt-get update -q \
	&& apt-get install -y \
	binutils \
	jsvc \
	mongodb-org-server \
	openjdk-8-jre-headless \
	--no-install-recommends

RUN     wget -O /tmp/unifi.deb https://dl.ubnt.com/unifi/${VERSION}/unifi_sysvinit_all.deb \
	&& dpkg -i /tmp/unifi.deb \
	&& apt-get install -fy \
	&& rm -rf /var/lib/apt/lists/*

WORKDIR /usr/lib/unifi
VOLUME /usr/lib/unifi/data

COPY run.sh /run.sh
RUN chmod 755 /run.sh

ENTRYPOINT [ "/run.sh" ]
CMD [  "start" ]

