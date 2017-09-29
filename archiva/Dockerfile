FROM ubuntu:16.04
LABEL Maintainer "Martin Buchleitner <martin@nitram.at>"

RUN apt-get -y -q update && \
    apt-get -y -q install software-properties-common && \
    add-apt-repository ppa:webupd8team/java && \
    echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    apt-get -y -q update && \
    apt-get install -qqy \
        oracle-java8-installer \
        libjna-java

ADD http://mirror.klaus-uwe.me/apache/archiva/2.2.3/binaries/apache-archiva-2.2.3-bin.zip /tmp/
RUN apt-get -q -y install unzip \
    && unzip -d "/tmp" "$(ls /tmp/apache-archiva*.zip)" \
    && mv "/tmp/apache-archiva-2.2.3/" "/archiva/" \
    && rm -rf "/tmp/*"
EXPOSE 8080
CMD /archiva/bin/archiva console
VOLUME ["/archiva/conf", "/archiva/data", "/archiva/repositories"]