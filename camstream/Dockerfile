FROM debian:10

LABEL maintainer "Martin Buchleitner <mabunixda@gmail.com>"

ENV RTSP_URL=""

RUN apt-get update -q \
    && apt-get install -y lighttpd ffmpeg gettext-base \
    && mkdir /var/www/cgi-bin

COPY *.conf /etc/lighttpd/conf-enabled

COPY web* /var/www/cgi-bin/
COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 80

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
