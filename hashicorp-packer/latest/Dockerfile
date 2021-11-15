FROM debian:buster

ENV DEBIAN_INTERACTIVE none
ARG PACKER_VERSION=1.7.8
ARG PACKER_SHA256SUM=8a94b84542d21b8785847f4cccc8a6da4c7be5e16d4b1a2d0a5f7ec5532faec0
ARG PACKAGE=packer_${PACKER_VERSION}_linux_amd64.zip

RUN apt-get update -qq \
    && apt-get install -y -q git bash wget openssl unzip \
    && rm -rf /var/lib/apt/lists/*

ADD https://releases.hashicorp.com/packer/${PACKER_VERSION}/${PACKAGE} ./
ADD https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_SHA256SUMS ./

RUN cat packer_${PACKER_VERSION}_SHA256SUMS | grep "${PACKAGE}" | sha256sum -c - \
    && unzip ${PACKAGE} -d /usr/local/bin \
    && rm -f ${PACKAGE} packer_${PACKER_VERSION}_SHA256SUMS
