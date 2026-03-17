#
# Dockerfile for privoxy
#

FROM alpine:3.23

RUN set -xe \
    && apk add --no-cache curl privoxy \
    && curl -sSL https://github.com/tianon/gosu/releases/download/1.19/gosu-amd64 > /usr/sbin/gosu \
    && chmod +x /usr/sbin/gosu \
    && apk del curl \
    && rm -rf /var/cache/apk/*



RUN sed -i -e '/^listen-address/s/127.0.0.1/0.0.0.0/' \
           -e '/^accept-intercepted-requests/s/0/1/' \
           -e '/^enforce-blocks/s/0/1/' \
           -e '/^#debug/s/#//' /etc/privoxy/config.new

VOLUME /etc/privoxy

EXPOSE 8118

CMD gosu privoxy privoxy --no-daemon /etc/privoxy/config.new
