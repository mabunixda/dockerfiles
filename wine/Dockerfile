FROM ubuntu:17.04
LABEL maintainer "Martin Buchleitner <mabunixda@gmail.com>"

# install wine
RUN apt-get update \
	&& apt-get install -y software-properties-common --no-install-recommends \
	&& apt-get install -y wine-development wine64-development --no-install-recommends \
	&& dpkg --add-architecture i386 \
	&& apt-get update \
	&& apt-get install -y wine32-development --no-install-recommends \
	&& add-apt-repository universe \
	&& apt-get update \
	&& apt-get install wine-gecko2.21 --no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

ENV HOME /root
WORKDIR $HOME