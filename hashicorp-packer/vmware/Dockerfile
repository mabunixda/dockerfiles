
FROM docker.io/mabunixda/hashicorp-packer

ARG GOVC_VERSION=0.27.1
ARG GOVC_ARCH=x86_64
ARG OVFTOOL_VERSION=4.4.3-18663434

RUN apt-get update -qq \
    && apt-get install -y -q curl libncursesw5 \
    && rm -rf /var/lib/apt/lists/*

ADD "VMware-ovftool-${OVFTOOL_VERSION}-lin.${GOVC_ARCH}.bundle" /tmp/
ADD "https://github.com/vmware/govmomi/releases/download/v${GOVC_VERSION}/govc_Linux_${GOVC_ARCH}.tar.gz" /tmp/

RUN sh "/tmp/VMware-ovftool-${OVFTOOL_VERSION}-lin.${GOVC_ARCH}.bundle" -p /usr/local --eulas-agreed --required --console \
    && tar -xz -C /usr/local/bin -f /tmp/govc_Linux_${GOVC_ARCH}.tar.gz \
    && rm -rf /tmp/*

