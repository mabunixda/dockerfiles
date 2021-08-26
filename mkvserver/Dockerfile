ARG FFMEG_VERSION=4.2.1
FROM docker.io/mabunixda/ffmpeg:${FFMEG_VERSION} AS build
WORKDIR /usr/src/
RUN  apk add --no-cache --virtual .build-deps git build-base curl tar bzip2 x264 openssl nasm \
  && git clone https://github.com/klaxa/mkvserver_mk2  \
  && cd mkvserver_mk2 \
  && make

ARG FFMEG_VERSION=4.2.1
FROM docker.io/mabunixda/ffmpeg:${FFMEG_VERSION}
COPY --from=build /usr/src/mkvserver_mk2/server /usr/local/bin/
