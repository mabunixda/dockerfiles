FROM debian:buster
LABEL maintainer "Martin Buchleitner <mabunixda@gmail.com>"

RUN apt-get update && apt-get install -y \
	ca-certificates \
	curl \
	dpkg \
	libicu63 \
	liblttng-ust0 \
	--no-install-recommends


RUN cd /usr/src \
	&& PSH_VERSION="$(curl -H "Accept: application/vnd.github.v3+json" -s https://api.github.com/repos/PowerShell/PowerShell/releases/latest | grep 'tag_name' | cut -d\" -f4 | sed -r 's .{1}  ')" \
	&& echo "Latest version on powershell github repo is" $PSH_VERSION \
	&& curl -L -o powershell.deb -O "https://github.com/PowerShell/PowerShell/releases/download/v${PSH_VERSION}/powershell_${PSH_VERSION}-1.debian.10_amd64.deb" \
	&& dpkg -i powershell.deb \
	&& apt-get install -fy \
	&& rm -rf /var/lib/apt/lists/* /usr/src/*

ENTRYPOINT [ "/usr/bin/pwsh" ]
