#
# touch sonos_nolb.cfg
# touch player_nolb.cfg
# ocker run -d \
#           -v ${PWD}/sonos_nolb.cfg:/loxone-sonos/system/sonos_nolb.cfg \
#           -v ${PWD}/player_nolb.cfg:/loxone-sonos/system/player_nolb.cfg \
#           -network host \
#           r.nitram.at/loxone-sonos
#

FROM alpine:3.5

LABEL maintainer="Martin Buchleitner <mabunixda@gmail.com>"

ARG BRANCH=master
ENV GITHUB_REPO=https://github.com/Liver64/LoxBerry-Sonos
ENV UID=999 GID=999

RUN BUILD_DEPS=" \
    git \
    gnupg \
    openssl" \
 && apk --no-cache -U add \
    ${BUILD_DEPS} \
    ca-certificates \
    nginx \
    s6 \
    su-exec \
    curl \
    lame \
    php7-fpm \
    php7-curl \
    php7-json \
    php7-sockets \
    php7-soap \
 && git clone $GITHUB_REPO /tmp \
 && cd /tmp \
 && git checkout $BRANCH \
 && mv /tmp/webfrontend/html /loxone-sonos \
 && apk del ${BUILD_DEPS} \
 && rm -rf /tmp/* /var/cache/apk/* /root/.gnupg

COPY nginx.conf /etc/nginx/nginx.conf
COPY php-fpm.conf /etc/php7/php-fpm.conf
COPY s6.d /etc/s6.d

COPY run.sh /usr/local/bin/run.sh

RUN chmod +x /usr/local/bin/run.sh /etc/s6.d/*/* /etc/s6.d/.s6-svscan/*

EXPOSE 8088

CMD ["run.sh"]
