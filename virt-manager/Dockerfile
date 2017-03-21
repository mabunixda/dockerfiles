FROM debian:jessie
LABEL maintainer "Martin Buchleitner <mabunixda@gmail.com>"

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y -q update && \
    apt-get install -y --no-install-recommends \
    libvirt-bin \
    netcat \
    virt-manager \
    ssh \
    ssh-askpass-gnome 

ENTRYPOINT  ["/usr/bin/virt-manager","--no-fork"]