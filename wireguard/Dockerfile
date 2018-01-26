# Usage:
#
# (this uses a custom kernel module hence the mounts)
# docker run --rm -it \
# 	--name wireguard \
# 	--privileged \
# 	-v /lib/modules:/lib/modules:ro \
# 	-v /usr/src:/usr/src:ro \
# 	r.j3ss.co/wireguard
#
FROM debian:jessie
LABEL maintainer "Martin Buchleitner <mabunixda@gmail.com>"

RUN echo "deb http://deb.debian.org/debian/ unstable main" > /etc/apt/sources.list.d/unstable-wireguard.list \
    && printf 'Package: *\nPin: release a=unstable\nPin-Priority: 150\n' > /etc/apt/preferences.d/limit-unstable \
    && apt-get update -q \
    && apt-get install -y wireguard

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
CMD [ "wg" ]
