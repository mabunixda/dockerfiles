FROM docker.io/adoptopenjdk/openjdk8:slim

LABEL maintainer="Martin Buchleitner <mabunixda@gmail.com>"

ENV VERSION=2020-06

ENV ECLIPSE_URL=http://ftp.halifax.rwth-aachen.de/eclipse/technology/epp/downloads/release/$VERSION/R/eclipse-javascript-$VERSION-R-linux-gtk-x86_64.tar.gz

ENV HOME /home/app

USER root

WORKDIR /opt/

RUN set -x \
    && apt-get update \
    && apt-get install -y wget gzip \
    && wget "$ECLIPSE_URL" -O - | tar xz \
	&& useradd --create-home --home-dir $HOME app \
	&& chown -R app:app $HOME \
  	&& rm -rf /var/lib/apt/lists/*

WORKDIR $HOME
USER app

CMD [ "/opt/eclipse/eclipse" ]
