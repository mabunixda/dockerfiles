FROM alpine:latest
LABEL maintainer "Martin Buchleitner <mabunixda@gmail.com>"

EXPOSE 1080

RUN apk add --no-cache openssh-client

RUN adduser -u 1000 -D app && mkdir -p ~app/.ssh/master && chown -R app: ~app

USER app
WORKDIR /home/app

ADD start.sh /usr/local/bin/start.sh

ENTRYPOINT ["/usr/local/bin/start.sh"]
