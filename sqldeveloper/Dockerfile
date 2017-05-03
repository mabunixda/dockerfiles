FROM ubuntu:17.04
LABEL MAINTAINER=mabunixda@gmail.com

# http://download.oracle.com/otn/java/sqldeveloper/sqldeveloper-4.2.0.17.089.1709-no-jre.zip"

ADD ./preload/ /tmp/sql

ENV HOME /home/app
RUN useradd --create-home --home-dir $HOME --uid 1000 app \
	&& chown -R app:app $HOME \
    && mkdir -p $HOME  \
    && apt-get update -q \
	&& apt-get install -y software-properties-common libxext6 libxrender1 libxtst6 libxi6 --no-install-recommends  \
    && add-apt-repository ppa:webupd8team/java \
    && apt-get update -q \
    && echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true |  /usr/bin/debconf-set-selections \
    && apt-get install -y oracle-java8-set-default \
    && apt-get install -y curl unzip \
    && xname=$(find /tmp/sql -maxdepth 1 -name "*.zip") \
    && cd /tmp \
    && unzip -d /usr/local $xname \
    && rm $xname

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle/
WORKDIR $HOME
CMD /usr/local/sqldeveloper/sqldeveloper.sh
