FROM debian:stretch

MAINTAINER Martin Buchleitner <mabunixda@gmail.com>

RUN set -x \
    && apt-get update && apt-get install -y \
	    libgssapi-krb5-2 \
	    rdesktop \
	    --no-install-recommends \
	&& apt-get -q -y clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*;

ENTRYPOINT [ "rdesktop" ]

