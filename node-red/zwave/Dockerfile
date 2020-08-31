FROM nodered/node-red:latest-12-minimal
USER root

RUN apk add --no-cache python3 python3-dev build-base
RUN apk add --no-cache --virtual .build-deps \
  libressl-dev \
  cmake \
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
  && make install \
  && apk del .build-deps

# to add zwave Controller permissions
RUN adduser node-red dialout

COPY package.json /usr/src/node-red/package-patch.json
RUN awk -F':' '{system("npm install "$1)}' package-patch.json \
  && rm -f /usr/src/node-red/package-patch.json
USER node-red
