FROM debian:jessie

# Tell debconf to run in non-interactive mode
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
	apt-transport-https \
	ca-certificates \
	curl \
	--no-install-recommends

# Add the skype debian repo
RUN curl -sSL https://repo.skype.com/data/SKYPE-GPG-KEY | apt-key add -
RUN echo "deb [arch=amd64] https://repo.skype.com/deb stable main" > /etc/apt/sources.list.d/skype.list

RUN apt-get update && apt-get -y install \
	skypeforlinux \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

# Make a user
ENV HOME /home/skype
RUN useradd --create-home --home-dir $HOME skype \
	&& chown -R skype:skype $HOME \
	&& usermod -a -G audio,video skype

WORKDIR $HOME
USER skype

# Start Skype
ENTRYPOINT ["skypeforlinux"]

