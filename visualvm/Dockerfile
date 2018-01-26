FROM ubuntu:17.10

# Install X11 tools and those needed here for downloads.
RUN apt-get update  -qq && apt-get install -qq -y \
	curl libxext-dev libxrender-dev libxtst-dev unzip wget openjdk-8-jdk \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* \
	&& rm -rf /tmp/*

ENV VISUALVM_URL https://github.com/visualvm/visualvm.src/releases/download/1.3.9/visualvm_139.zip


RUN wget --progress=bar:force $VISUALVM_URL -O /tmp/visualvm.zip \
    && cd /tmp \
    && unzip visualvm.zip -d /usr/local \
    && ln -s $(ls -d /usr/local/visualvm_*) /usr/local/visualvm \
    && rm -rf /tmp/*

# Make a user
ENV HOME /home/app
RUN useradd --create-home --home-dir $HOME --uid 1000 app \
	&& chown -R app:app $HOME
WORKDIR $HOME
USER app

CMD ["/usr/local/visualvm/bin/visualvm"]
