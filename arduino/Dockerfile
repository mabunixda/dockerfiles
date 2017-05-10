FROM anapsix/alpine-java:8_jdk

ENV ARDUINO_VERSION 1.8.2

RUN apk add --no-cache wget xz \
    && cd /tmp \
    && wget https://downloads.arduino.cc/arduino-${ARDUINO_VERSION}-linux64.tar.xz \
    && tar xf arduino-${ARDUINO_VERSION}-linux64.tar.xz \
    && mv arduino-${ARDUINO_VERSION} /arduino \
    && rm -rf /tmp/* 

WORKDIR /arduino

ENTRYPOINT ["./arduino"]

