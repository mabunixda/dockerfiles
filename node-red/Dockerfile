FROM nodered/node-red-docker:slim-v8
USER root
RUN apk add --no-cache git \
	 libssl1.0 libressl-dev \
	 build-base cmake \
        	 python python-dev \
        	 zlib zlib-dev \
	         udev eudev-dev \
        	 tzdata \
	         linux-headers \
        	 libusb libusb-dev libusb-compat-dev \
     && git clone https://github.com/OpenZWave/open-zwave.git /src/open-zwave-read-only \
     && cd /src/open-zwave-read-only \
     && LIBUSB_INCLUDE_DIR=/usr/include/libusb-1.0/ make  \
     && make install \
     && rm -rf /src/open-zwave-read-only

USER node-red
COPY package.json /usr/src/node-red/

RUN npm install