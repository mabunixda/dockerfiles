FROM debian:stretch
MAINTAINER Jessie Frazelle <jess@linux.com>

RUN apt-get update && apt-get install -y \
	libasound2 \
	libatk1.0-0 \
	libcairo2 \
	libcups2 \
	libdatrie1 \
	libdbus-1-3 \
	libfontconfig1 \
	libfreetype6 \
	libgconf-2-4 \
	libgcrypt20 \
	libgl1-mesa-dri \
	libgl1-mesa-glx \
	libgdk-pixbuf2.0-0 \
	libglib2.0-0 \
	libgtk2.0-0 \
	libgpg-error0 \
	libgraphite2-3 \
	libnotify-bin \
	libnss3 \
	libnspr4 \
	libpango-1.0-0 \
	libpangocairo-1.0-0 \
	libxcomposite1 \
	libxcursor1 \
	libxdmcp6 \
	libxi6 \
	libxrandr2 \
	libxrender1 \
	libxss1 \
	libxtst6 \
	liblzma5 \
	--no-install-recommends

ENV HOME /home/user
RUN useradd --create-home --home-dir $HOME user \
	&& chown -R user:user $HOME

# https://code.visualstudio.com/Download
ENV CODE_VERSION 1.10.1-1488415350
ENV CODE_COMMIT 653f8733dd5a5c43d66d7168b4701f94d72b62e5

# download the source
RUN buildDeps=' \
		ca-certificates \
		curl \
		gnupg \
	' \
	&& set -x \
	&& apt-get update && apt-get install -y $buildDeps --no-install-recommends \
	&& curl -sL https://deb.nodesource.com/setup_6.x | bash - \
	&& apt-get update && apt-get install -y nodejs git --no-install-recommends \
	&& rm -rf /var/lib/apt/lists/* \
	&& curl -sSL "https://az764295.vo.msecnd.net/stable/${CODE_COMMIT}/code_${CODE_VERSION}_amd64.deb" -o /tmp/vs.deb \
	&& dpkg -i /tmp/vs.deb \
	&& rm -rf /tmp/vs.deb \
	&& apt-get purge -y --auto-remove $buildDeps

COPY start.sh /usr/local/bin/start.sh
COPY local.conf /etc/fonts/local.conf

WORKDIR $HOME

ENTRYPOINT [ "/usr/local/bin/start.sh" ]
