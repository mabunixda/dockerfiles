FROM alpine:3

RUN apk add --no-cache unbound drill bash

EXPOSE 53/udp 53/tcp

VOLUME /etc/unbound

ENTRYPOINT ["unbound"]
CMD ["-d"]

