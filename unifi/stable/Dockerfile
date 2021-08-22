FROM ubuntu:18.04
LABEL maintainer "Martin Buchleitner <mabunixda@gmail.com>"

ARG VERSION=6.0.41

EXPOSE 8080/tcp 8443/tcp 6789/tcp 8880/tcp 8843/tcp 27117/tcp
EXPOSE 1900/udp 3478/udp 10001/udp

ENV DEBIAN_FRONTEND="noninteractive"
ENV BASEDIR=/usr/lib/unifi

RUN apt-get update -q \
	&& apt-get install -y curl apt-transport-https gnupg2 dirmngr ca-certificates --no-install-recommends  \
        && curl -L https://www.mongodb.org/static/pgp/server-3.6.asc | apt-key add - \
	&& echo "deb [ arch=amd64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.6 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.6.list \
	&& apt-get update -q \
	&& apt-get install -y \
	binutils \
	jsvc \
  logrotate \
  libcap2 \
	mongodb-org-server \
	openjdk-8-jre-headless \
	--no-install-recommends

RUN  curl -L -o /tmp/unifi.deb https://dl.ubnt.com/unifi/${VERSION}/unifi_sysvinit_all.deb \
  && dpkg -i /tmp/unifi.deb \
  && apt-get install -fy \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/lib/unifi
VOLUME /usr/lib/unifi/data

COPY run.sh /run.sh
RUN chmod 755 /run.sh

ENTRYPOINT [ "/run.sh" ]
CMD [  "start" ]
