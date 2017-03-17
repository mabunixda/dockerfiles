FROM debian:stretch
MAINTAINER Martin Buchleitner <mabunixda@gmail.com>

RUN apt-get update && apt-get install -y \
	libgl1-mesa-dri \
	libgl1-mesa-glx \
	vlc \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

ENV HOME /home/app
RUN useradd --create-home --home-dir $HOME app \
	&& chown -R app:app $HOME \
	&& usermod -a -G audio,video app

WORKDIR $HOME
USER app

ENTRYPOINT [ "vlc" ]