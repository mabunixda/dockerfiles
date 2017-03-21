FROM debian:stretch
LABEL maintainer "Martin Buchleitner <mabunixda@gmail.com>"

RUN apt-get update && apt-get install -y \
	alsa-utils \
	libasound2 \
	libasound2-plugins \
	pulseaudio \
	pulseaudio-utils \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

ENV HOME /home/app
RUN useradd --create-home --home-dir $HOME app \
	&& usermod -aG audio,pulse,pulse-access app \
	&& chown -R app:app $HOME

WORKDIR $HOME
USER app

COPY default.pa /etc/pulse/default.pa
COPY client.conf /etc/pulse/client.conf
COPY daemon.conf /etc/pulse/daemon.conf

ENTRYPOINT [ "pulseaudio" ]
CMD [ "--log-level=4", "--log-target=stderr", "-v" ]
