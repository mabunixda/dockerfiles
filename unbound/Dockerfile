FROM alpine:latest

EXPOSE 53/udp 53/tcp
VOLUME /etc/unbound

RUN apk add --no-cache unbound

ENTRYPOINT ["unbound"]
CMD ["-d"]
