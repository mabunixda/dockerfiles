FROM adoptopenjdk/openjdk8:slim
LABEL maintainer "Martin Buchleitner <mabunixda@gmail.com>"

ARG version=3.10.7
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -q \
	&& apt-get install -y  apt-transport-https gnupg2 dirmngr --no-install-recommends  \
        && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4  \
	&& echo "deb [ arch=amd64 ] http://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.4.list \
	&& apt-get update -q \
        && apt-get install -y  \
    jsvc \
    jq \
    moreutils \
    openjdk-8-jre-headless \
    patch \
    sudo \
    tzdata \
    mongodb-org-server \
    mongodb-org-shell \
    moreutils \
    curl

RUN curl -o /tmp/unifi-video.deb https://dl.ubnt.com/firmwares/ufv/v${version}/unifi-video.Debian9_amd64.v${version}.deb && \
  apt-get install -q -y psmisc lsb-release \
  && dpkg -i /tmp/unifi-video.deb && \
  rm -rf /tmp/* && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* 

ENV DATADIR "/var/lib/unifi-video"
ENV BASEDIR "/usr/lib/unifi-video"

# Configuration and database volume
VOLUME ["${DATADIR}"]

# Video storage volume
VOLUME ["${DATADIR}/videos"]

# RTMP, RTMPS & RTSP via the controller
EXPOSE 1935/tcp 7444/tcp 7447/tcp

# Inbound Camera Streams & Camera Management (NVR Side)
EXPOSE 6666/tcp 7442/tcp

# UVC-Micro Talkback (Camera Side)
EXPOSE 7004/tcp

# HTTP & HTTPS Web UI + API
EXPOSE 7080/tcp 7443/tcp

# Video over HTTP & HTTPS
EXPOSE 7445/tcp 7446/tcp

WORKDIR "${BASEDIR}"
COPY run.sh /run.sh
RUN chmod 755 /run.sh
ENTRYPOINT ["/run.sh"]
