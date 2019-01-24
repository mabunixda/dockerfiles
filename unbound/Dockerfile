FROM alpine:3.8

RUN apk add --no-cache unbound

EXPOSE 53/udp 53/tcp

VOLUME /etc/unbound

ENTRYPOINT ["unbound"]
CMD ["-d"]

