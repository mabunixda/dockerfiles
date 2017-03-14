FROM ubuntu:16.04
MAINTAINER Martin Buchleitner <mabunixda@gmail.com>

ENV HOME /home/app

RUN mkdir -p $HOME  \
    &&  apt-get update -q \
	&& apt-get install -y software-properties-common libxext6 libxrender1 libxtst6 libxi6 --no-install-recommends  \
    &&add-apt-repository ppa:webupd8team/java \
    && apt-get update -q \
    && echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true |  /usr/bin/debconf-set-selections \
    && apt-get install -y oracle-java8-set-default 

ADD JDownloader.jar /usr/src
ADD start.sh /usr/local/bin

RUN useradd --create-home --uid 1000 --home-dir $HOME app  \
    && chown -R app:app $HOME

USER app
WORKDIR $HOME

CMD	[ "/usr/local/bin/start.sh" ]
