## Supports x86_64, x86, armhf, arm64, ppc64le, armle
ARG ZEROTIER_VERSION=1.10.5
FROM debian:bullseye-slim as builder
ARG ZEROTIER_VERSION

## Supports x86_64, x86, arm, and arm64

RUN apt-get update && apt-get install -y curl gnupg
RUN apt-key adv --keyserver keys.openpgp.org --recv-keys 0x1657198823E52A61  && \
    echo "deb http://download.zerotier.com/debian/buster buster main" > /etc/apt/sources.list.d/zerotier.list
RUN apt-get update && apt-get install -y zerotier-one=${ZEROTIER_VERSION}
# COPY ext/installfiles/linux/zerotier-containerized/main.sh /var/lib/zerotier-one/main.sh

FROM debian:bullseye-slim
ARG ZEROTIER_VERSION
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

RUN mkdir -p /var/lib/zerotier-one
COPY --from=builder /usr/sbin/zerotier-cli /usr/sbin/zerotier-cli
COPY --from=builder /usr/sbin/zerotier-idtool /usr/sbin/zerotier-idtool
COPY --from=builder /usr/sbin/zerotier-one /usr/sbin/zerotier-one

EXPOSE 9993/udp

CMD ["/usr/sbin/zerotier-one"]