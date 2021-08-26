FROM debian:buster

ENV DEBIAN_FRONTEND noninteractive
ENV TINI_VERSION v0.19.0

ENV RTSP_URI=""

EXPOSE 8080


ADD entrypoint.sh /

ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini-static /tini
RUN chmod +x /tini



RUN apt-get update && \
	apt-get install -y --no-install-recommends \
		ca-certificates \
		libgl1-mesa-dri \
		libgl1-mesa-glx \
		pulseaudio \
		alsa-utils \
		dbus* \
		vlc && \
	apt-get -y -f install && \
	useradd -m app && \
	usermod -a -G audio,video app && \
	rm -rf /var/lib/apt/lists/*


USER app
WORKDIR /home/app

ENTRYPOINT ["/tini", "--"]

CMD [ "/entrypoint.sh" ]