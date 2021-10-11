FROM docker.io/alpine:3.14
Label maintainer "Martin Buchleitner <mabunixda@gmail.com>"

RUN apk add --no-cache openssh-server rsync runit \
    && mkdir /var/run/sshd


ADD . /etc/

ENV REMOTE_USERNAME=root
EXPOSE 22 873

VOLUME ["/data"]
VOLUME ["/home/app/.ssh/"]

CMD ["/etc/run.sh"]
