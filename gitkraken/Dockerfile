FROM debian:stretch

RUN gitkrakenDeps='\
    gconf2 \
    gconf-service \
    libcurl3 \
    libgtk2.0-0 \
    libudev1 \
    libgcrypt20 \
    libnotify4 \
    libxtst6 \
    libnss3 \
    python \
    gvfs-bin \
    libxss1 \
    libasound2 \
	libgnome-keyring0 \
    xdg-utils' \
    installDeps='\
    wget \
    ca-certificates' \
    set -x \
    && apt-get update -y \
    && apt-get install -y $gitkrakenDeps --no-install-recommends \
    && apt-get install -y $installDeps --no-install-recommends \
    && rm -rf /var/lib/apt/lists/* 
#    && apt-get purge -y --auto-remove $installDeps


RUN wget --quiet "https://release.gitkraken.com/linux/gitkraken-amd64.deb" -O /tmp/gitkraken-amd64.deb \
    && dpkg -i /tmp/gitkraken-amd64.deb \
    && rm /tmp/gitkraken-amd64.deb

ENV HOME /home/app
RUN useradd --create-home --home-dir $HOME app \
	&& chown -R app:user $HOME

WORKDIR $HOME
USER app
ENTRYPOINT ["/usr/bin/gitkraken"]
