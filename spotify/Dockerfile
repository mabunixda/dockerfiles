
FROM debian:buster
LABEL maintainer "Martin Buchleitner <mabunixda@gmail.com>"

RUN	apt-get update && apt-get install -y \
	dirmngr \
	gnupg \
        curl \
        && curl -sS https://download.spotify.com/debian/pubkey.gpg | apt-key add -  \
	&& echo "deb http://repository.spotify.com stable non-free" >> /etc/apt/sources.list.d/spotify.list \
	&& apt-get update && apt-get install -y \
	alsa-utils \
	libpangoxft-1.0-0 \
	spotify-client \
	xdg-utils \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

ENV HOME /home/app
RUN useradd --create-home --home-dir $HOME app \
	&& gpasswd -a app audio \
	&& chown -R app:app $HOME

WORKDIR $HOME
USER app

# make search bar text better
RUN echo "QLineEdit { color: #000 }" > $HOME/spotify-override.css

ENTRYPOINT	[ "spotify" ]
CMD [ "-stylesheet=~/spotify-override.css" ]
