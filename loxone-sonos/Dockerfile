FROM alpine:3.5

LABEL maintainer="Martin Buchleitner <mabunixda@gmail.com>"

ENV GITHUB_REPO=https://github.com/Liver64/PHP-Sonos-and-Loxone
ENV UID=991 GID=991

RUN BUILD_DEPS=" \
    git \
    gnupg \
    openssl \
    wget" \
 && apk --no-cache -U add \
    ${BUILD_DEPS} \
    ca-certificates \
    nginx \
    s6 \
    su-exec \
    php7-fpm \
    php7-curl \
    php7-iconv \
    php7-xml \
    php7-dom \
    php7-openssl \
    php7-json \
    php7-zlib \
    php7-pdo_mysql \
    php7-pdo_sqlite \
    php7-sqlite3 \
    php7-ldap \
 && git clone $GITHUB_REPO /loxone-sonos \
 && mkdir -p /loxone-sonos/log \
 && ln -s /dev/stderr /loxone-sonos/log/sonos_error.log \
 && apk del ${BUILD_DEPS} \
 && rm -rf /tmp/* /var/cache/apk/* /root/.gnupg


COPY nginx.conf /etc/nginx/nginx.conf
COPY php-fpm.conf /etc/php7/php-fpm.conf
COPY s6.d /etc/s6.d
COPY run.sh /usr/local/bin/run.sh

RUN chmod +x /usr/local/bin/run.sh /etc/s6.d/*/* /etc/s6.d/.s6-svscan/*

EXPOSE 8080

CMD ["run.sh"]
