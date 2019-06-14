FROM debian:stretch
LABEL maintainer "Martin Buchleitner <mabunixda@gmail.com>"

ENV DEBIAN_FRONTEND noninteractive
ENV JVM_MAX_MEM 1024M

RUN apt-get update -q \
	&& apt-get install -y  apt-transport-https gnupg2 dirmngr --no-install-recommends  \
        && echo 'deb http://www.ui.com/downloads/unifi/debian stable ubiquiti' >  /etc/apt/sources.list.d/100-ubnt-unifi.list \
	&& apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6 \
        && apt-key adv --keyserver keyserver.ubuntu.com --recv 06E85760C0A52C50  \
	&& echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.4.list \
	&& apt-get update -q \
        && apt-get install -y unifi \
	&& rm -rf /var/lib/apt/lists/* 

EXPOSE 6789/tcp 8080/tcp 8443/tcp 8880/tcp 8843/tcp 27117/tcp
EXPOSE 1900/udp 3478/udp 10001/udp 
WORKDIR /usr/lib/unifi
ADD run.sh /usr/local/bin/
ENTRYPOINT [ "/usr/local/bin/run.sh" ]
CMD ["start"]
