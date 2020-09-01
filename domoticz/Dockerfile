FROM debian:buster

LABEL Maintainer "Martin Buchleitner <martin@nitram.at>"

ENV TZ Europe/Vienna
ENV VERSION=2020.2
ENV CMAKE_VERSION=v3.17.0

RUN apt-get update -qq \
	&& apt-get install -y curl \
		make \
		gcc \
		g++ \
		libssl-dev \
		git \
		libcurl4-gnutls-dev \
		libusb-dev \
		python3-dev \
		zlib1g-dev \
		libcereal-dev \
		liblua5.3-dev \
		uthash-dev \
		libmosquitto-dev

RUN git clone https://github.com/Kitware/CMake /src/cmake \
	&& cd /src/cmake \
	&& git checkout -b "${CMAKE_VERSION}" "tags/${CMAKE_VERSION}" \
	&& ./bootstrap \
	&& make \
	&& make install

RUN git clone https://github.com/OpenZWave/open-zwave.git /src/open-zwave-read-only \
     && cd /src/open-zwave-read-only \
     && LIBUSB_INCLUDE_DIR=/usr/include/libusb-1.0/ make  \
     && make install

RUN curl -L -o /src/boost_1_72_0.tar.gz https://dl.bintray.com/boostorg/release/1.72.0/source/boost_1_72_0.tar.gz \
	&& tar -xz -C /src/ -f /src/boost_1_72_0.tar.gz \
	&& cd /src/boost_1_72_0/ \
	&& ./bootstrap.sh \
	&& ./b2 stage threading=multi link=static --with-thread --with-system \
	&& ./b2 install threading=multi link=static --with-thread --with-system


RUN git clone https://github.com/domoticz/domoticz /src/domoticz \
    && cd /src/domoticz \
    && git checkout -b "$VERSION" "tags/$VERSION" \
	&& cmake -DCMAKE_BUILD_TYPE=Release -DUSE_BUILTIN_MQTT=NO CMakeLists.txt \
    && make \
    && make install

RUN rm -rf /src/* \
	&& mkdir -p /config/images \
    && ln -s /config/images /opt/domoticz/www/images

VOLUME /config /opt/domoticz/scripts

EXPOSE 8080

ENTRYPOINT ["/opt/domoticz/domoticz", "-dbase", "/config/domoticz.db", "-www", "8080", "-webroot", "zwave"]
