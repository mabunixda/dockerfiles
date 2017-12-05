FROM ubuntu:16.04
LABEL maintainer "Martin Buchleitner <mabunixda@gmail.com>"

RUN apt-get update && apt-get install -y \
	ca-certificates \
	curl \
	libcurl3 \
	libicu55 \
	libssl1.0.0 \
	libunwind8 \
	dpkg \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/* \

RUN cd /usr/src \
	&& VERSION="$(curl -sX GET https://api.github.com/repos/PowerShell/PowerShell/releases/latest | grep 'tag_name' | cut -d\" -f4 | sed -r 's .{1}  ')" \
	&& echo "Latest version on powershell github repo is" $VERSION \
	&& curl -L -o powerhsell.deb -O "https://github.com/PowerShell/PowerShell/releases/download/v${VERSION}/powershell_${VERSION}-1.ubuntu.16.04_amd64.deb" \
	&& dpkg -i powershell.deb \
	&& apt-get install -fy \
	&& rm -rf /var/lib/apt/lists/* /usr/src/*

ENTRYPOINT [ "/usr/bin/powershell" ]
