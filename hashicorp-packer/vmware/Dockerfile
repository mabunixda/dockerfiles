
FROM mabunixda/hashicorp-packer

ENV OVFTOOL_VERSION 4.1.0-2459827
ENV OVFTOOL_INSTALLER=vmware-ovftool-${OVFTOOL_VERSION}-lin.x86_64.bundle 

RUN apt-get update -qq \
    && apt-get install -y -q libncursesw5 \
    && rm -rf /var/lib/apt/lists/*

ADD "https://storage.googleapis.com/mortarchive/pub/ovftool/${OVFTOOL_INSTALLER}" /
RUN sh ${OVFTOOL_INSTALLER} -p /usr/local --eulas-agreed --required --console \
    && rm -f ${OVFTOOL_INSTALLER}*

ENTRYPOINT ["/bin/bash", "-c"]
