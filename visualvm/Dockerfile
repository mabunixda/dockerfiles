FROM docker.io/adoptopenjdk/openjdk8:slim

ARG VERSION=1.3.9

# Install X11 tools and those needed here for downloads.
RUN apt-get update  -qq && apt-get install -qq -y \
	libxext-dev libxrender-dev libxtst-dev unzip wget \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* \
	&& rm -rf /tmp/*


WORKDIR /tmp

RUN wget --progress=bar:force https://github.com/visualvm/visualvm.src/releases/download/${VERSION}/visualvm_$(echo $VERSION | tr -d '.').zip -O /tmp/visualvm.zip \
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
