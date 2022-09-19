FROM debian:buster
LABEL maintainer "Martin Buchleitner <mabunixda@gmail.com>"

RUN apt-get update && apt-get install -y \
	ca-certificates \
	curl \
	dpkg \
	libicu63 \
	liblttng-ust0 \
	--no-install-recommends

ENV PSH_VERSION=7.2.6
LABEL version="${PSH_VERSION}"


RUN  curl -L -o /tmp/powershell.deb -O "https://github.com/PowerShell/PowerShell/releases/download/v${PSH_VERSION}/powershell_${PSH_VERSION}-1.deb_amd64.deb" \
	&& dpkg -i /tmp/powershell.deb \
	&& apt-get install -fy \
	&& rm -rf /var/lib/apt/lists/* /tmp/*

ENTRYPOINT [ "/usr/bin/pwsh" ]
