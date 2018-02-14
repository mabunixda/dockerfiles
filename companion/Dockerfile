FROM debian:stretch
LABEL maintainer "Martin Buchleitner <mabunixda@gmail.com>"

ENV VERSION=2.2.0

ADD http://downloads.open-tx.org/2.2/companion/linux/companion22_${VERSION}_amd64.deb /tmp/companion.deb

RUN apt-get update && \
    dpkg --force-depends -i /tmp/companion.deb \
    && apt-get -f install -y \
    && rm -rf /var/lib/apt/lists/* \
	&& rm -rf /tmp/*


RUN groupadd -r app && useradd -r -g app -G audio,video --uid 1000 app \
    && mkdir -p /home/app/ && chown -R app:app /home/app \
	&& mkdir -p /var/run/dbus

USER app

ENTRYPOINT [ "/usr/local/bin/companion22" ]


