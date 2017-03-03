FROM debian:jessie
MAINTAINER Jessie Frazelle <jess@linux.com>

RUN buildDeps=' \
		ca-certificates \
		curl \
		gnupg \
	' \
	&& set -x \
	&& apt-get update && apt-get install -y $buildDeps --no-install-recommends \
	&& rm -rf /var/lib/apt/lists/* \
	&& curl -sSL https://www.virtualbox.org/download/oracle_vbox_2016.asc | apt-key add - \
	&& echo "deb http://download.virtualbox.org/virtualbox/debian stretch contrib" >> /etc/apt/sources.list.d/virtualbox.list \
	&& apt-get update && apt-get install -y \
	virtualbox-5.0 \
	--no-install-recommends \
	&& apt-get purge -y --auto-remove $buildDeps

ENTRYPOINT	[ "/usr/bin/virtualbox" ]