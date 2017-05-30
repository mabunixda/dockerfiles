FROM java:jre-alpine

label MAINTAINER "Martin Buchleitner <mabunixda@gmail.com>"

VOLUME "/data"

ADD download.sh /
RUN apk add --no-cache bash curl && chmod +x /download.sh && /download.sh && rm -f /download.sh

CMD [ "java", "-jar", "/srv/ha-bridge.jar" ]
