FROM debian:stretch

LABEL maintainer "Martin Buchleitner <mabunixda@gmail.com>"

ENV HOME /home/app
# https://code.visualstudio.com/Download

ENV CODE_COMMIT b813d12980308015bcd2b3a2f6efa5c810c33ba5
ENV CODE_VERSION 1.17.2-1508162334

# download the source
RUN set -x \
	&& useradd --create-home --home-dir $HOME app \
	&& chown -R app:app $HOME \
	&& apt-get update -qq && apt-get install -y \
	procps \
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
	openssh-client \
	--no-install-recommends \
	&& buildDeps=' \
		ca-certificates \
		curl \
		gnupg \
	' \
	&& apt-get update && apt-get install -y $buildDeps --no-install-recommends \
	&& curl -sL https://deb.nodesource.com/setup_6.x | bash - \
	&& apt-get update && apt-get install -y nodejs git --no-install-recommends \
	&& curl -sSL "https://az764295.vo.msecnd.net/stable/${CODE_COMMIT}/code_${CODE_VERSION}_amd64.deb" -o /tmp/vs.deb \
	&& dpkg --force-depends  -i /tmp/vs.deb \
	&& apt-get install -fy \
	&& rm -rf /var/lib/apt/lists/* \
	&& rm -rf /tmp/vs.deb

COPY start.sh /usr/local/bin/start.sh
COPY local.conf /etc/fonts/local.conf

WORKDIR $HOME
USER app
ENTRYPOINT [ "/usr/local/bin/start.sh" ]
