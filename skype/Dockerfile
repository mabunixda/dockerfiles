FROM debian:jessie

# Tell debconf to run in non-interactive mode
ENV DEBIAN_FRONTEND noninteractive

# Setup multiarch because Skype is 32bit only
# Make sure the repository information is up to date
RUN dpkg --add-architecture i386 && \
	apt-get update && apt-get install -y \
	ca-certificates \
	curl \
	--no-install-recommends

ENV SKYPE_VERSION 4.3.0.37-1

# Install Skype
RUN curl -sSL "https://download.skype.com/linux/skype-debian_${SKYPE_VERSION}_i386.deb" > /usr/src/skype.deb && \
	dpkg --force-depends -i /usr/src/skype.deb && \
	apt-get install -fy \
	&& rm -rf /var/lib/apt/lists/*

# Make a user
ENV HOME /home/app
RUN useradd --create-home --home-dir $HOME --uid 1000 app \
	&& chown -R app:app $HOME \
	&& usermod -a -G audio,video app

WORKDIR $HOME
USER app

# Start Skype
# ENTRYPOINT ["/usr/bin/skype"]
CMD [ "skype"]