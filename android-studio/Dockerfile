FROM ubuntu:16.04
LABEL maintainer "Martin Buchleitner <mabunixda@gmail.com>"

ENV ANDROIDSTUDIO_VERSION 2.3.0.8
ENV ANDROIDSTUDIO_BUILD 162.3764568



# ENV DEBIAN_FRONTEND=noninteractive
RUN buildDeps='\
	curl \
	ca-certificates \
	unzip \
	'  \
	androidStudioDeps=' \
	libc6:i386 \
	libncurses5:i386 \
	libstdc++6:i386 \
	lib32z1 \
	libbz2-1.0:i386 \
	' \
	apt-get update -q \
	&& apt-get install -y software-properties-common libxext6 libxrender1 libxtst6 libxi6 --no-install-recommends  \
    && add-apt-repository ppa:webupd8team/java \
    && apt-get update -q \
    && echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true |  /usr/bin/debconf-set-selections \
    && apt-get install -y oracle-java8-set-default \
	&& apt-get install -y curl ca-certificates unzip --no-install-recommends \
	&& apt-get install -y $androidStudioDeps --no-install-recommends \ 	
	&& echo "https://dl.google.com/dl/android/studio/ide-zips/${ANDROIDSTUDIO_VERSION}/android-studio-ide-${ANDROIDSTUDIO_BUILD}-linux.zip" \
	&& curl  "https://dl.google.com/dl/android/studio/ide-zips/${ANDROIDSTUDIO_VERSION}/android-studio-ide-${ANDROIDSTUDIO_BUILD}-linux.zip" -o /tmp/android-studio.zip \
	&& unzip /tmp/android-studio.zip -d /usr/local \
	&& rm /tmp/android-studio.zip \
	&& apt-get remove --purge $buildDeps \
	&& rm -rf /var/lib/apt/lists/*  
	

ENV HOME /home/app
RUN useradd --create-home --uid 1000 --home-dir $HOME app \
	&& chown -R app:app $HOME

USER app
WORKDIR $HOME

ENTRYPOINT	[ "/usr/local/android-studio/bin/studio.sh" ]
