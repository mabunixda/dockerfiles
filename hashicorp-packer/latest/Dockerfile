FROM debian:buster

ENV DEBIAN_INTERACTIVE none
ENV PACKER_VERSION=1.4.2
ENV PACKER_SHA256SUM=2fcbd1662ac76dc4dec381bdc7b5e6316d5b9d48e0774a32fe6ef9ec19f47213

RUN apt-get update -qq \
    && apt-get install -y -q git bash wget openssl unzip \
    && rm -rf /var/lib/apt/lists/* 

ADD https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip ./
ADD https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_SHA256SUMS ./

RUN sed -i '/.*linux_amd64.zip/!d' packer_${PACKER_VERSION}_SHA256SUMS \
    && sha256sum -c packer_${PACKER_VERSION}_SHA256SUMS \
    && unzip packer_${PACKER_VERSION}_linux_amd64.zip -d /bin \
    && rm -f packer_${PACKER_VERSION}_linux_amd64.zip \

