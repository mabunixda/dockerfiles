## Supports x86_64, x86, armhf, arm64, ppc64le, armle
FROM debian:buster as builder
ARG ZEROTIER_VERSION=1.8.6

RUN apt-get update \
    && apt-get install -y curl
RUN export DISTRO=$(grep -v "^#" /etc/apt/sources.list | head -n1 |awk '{print $3}') \
    && export ARCH=$(dpkg --print-architecture) \
    && curl -sSL -o /tmp/zerotier-one.deb "https://download.zerotier.com/debian/${DISTRO}/pool/main/z/zerotier-one//zerotier-one_${ZEROTIER_VERSION}_${ARCH}.deb"

FROM debian:buster-slim
ARG ZEROTIER_VERSION=1.8.6
ARG BUILD_DATE
ENV VERSION=${ZEROTIER_VERSION}
LABEL version="${ZEROTIER_VERSION}" \
    description="Containerized ZeroTier One for use on CoreOS or other Docker-only Linux hosts." \
    org.label-schema.schema-version="1.0" \
    org.label-schema.name="zerotier" \
    org.label-schema.description="Containerized ZeroTier One for use on CoreOS or other Docker-only Linux hosts." \
    org.label-schema.build-date="${BUILD_DATE}" \
    org.label-schema.url="https://zerotier.com" \
    org.label-schema.version="{$ZEROTIER_VERSION}" \
    org.label-schema.docker.cmd="docker run --device=/dev/net/tun \
    --net=host \
    --cap-add=NET_ADMIN \
    --cap-add=SYS_ADMIN \
    -v /var/lib/zerotier-one:/var/lib/zerotier-one \
    -n zerotier-one \
    -d mabunixda/zerotier"


COPY --from=builder /tmp/zerotier-one.deb /tmp/zerotier-one.deb

RUN apt-get update \
    && apt-get install -y /tmp/zerotier-one.deb \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 9993/udp

CMD ["/usr/sbin/zerotier-one"]