FROM java:jre-alpine

label MAINTAINER "Martin Buchleitner <mabunixda@gmail.com>"

VOLUME "/srv/data"

ADD *.sh /
RUN apk add --no-cache bash curl && chmod +x /download.sh && /download.sh && rm -f /download.sh

ENTRYPOINT [ "/start.sh" ]
CMD [ "-Dserver.port=8081", "-Dconfig.file=/srv/data/habridge.config"]
