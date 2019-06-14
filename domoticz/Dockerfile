FROM alpine:3.6
LABEL Maintainer "Martin Buchleitner <martin@nitram.at>"

ENV TZ Europe/Vienna
ENV RELEASE 4.9700
RUN apk add --no-cache git \
	 python3 python3-dev \
	 libssl1.0 libressl-dev \
	 build-base cmake \
	 boost-dev \
	 boost-thread \
	 boost-system \
	 boost-date_time \
	 sqlite sqlite-dev \
	 curl libcurl curl-dev \
	 libusb libusb-dev libusb-compat-dev \
	 coreutils \
	 zlib zlib-dev \
	 udev eudev-dev \
	 tzdata \
	 linux-headers 

RUN git clone https://github.com/OpenZWave/open-zwave.git /src/open-zwave-read-only \
     && cd /src/open-zwave-read-only \
     && LIBUSB_INCLUDE_DIR=/usr/include/libusb-1.0/ make  \
     && make install 

RUN git clone https://github.com/domoticz/domoticz.git /src/domoticz \
     && cd /src/domoticz \
     && git checkout master  \
     && cmake -DCMAKE_BUILD_TYPE=Release CMakeLists.txt -DUSE_OPENSSL_STATIC="NO" \
     && make -j 4 \
     && make install \
     && rm -rf /src/domoticz \ 
     && ln -s /config/images /opt/domoticz/www/images 

RUN apk del git \
		cmake \
		python3-dev \
		linux-headers \
		libusb-dev \
		zlib-dev \
		libressl-dev \
		boost-dev \
		sqlite-dev \
		build-base \
		eudev-dev \
		coreutils \
		curl-dev

VOLUME /config /opt/domoticz/scripts

EXPOSE 8080

ENTRYPOINT ["/opt/domoticz/domoticz", "-dbase", "/config/domoticz.db", "-www", "8080", "-webroot", "zwave"]
