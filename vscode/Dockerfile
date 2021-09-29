FROM debian:11-slim

LABEL maintainer "Martin Buchleitner <mabunixda@gmail.com>"

ENV HOME /home/app

# Tell debconf to run in non-interactive mode
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
	apt-transport-https \
	ca-certificates \
	curl \
	gnupg \
	--no-install-recommends

# Add the vscode debian repo
RUN curl -sSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | apt-key add -
RUN echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list

RUN useradd --create-home --home-dir $HOME app \
    && groupadd -g 109 vboxsf \
	&& usermod -G vboxsf -a app \
    && chown -R app:app $HOME

RUN apt-get update && apt-get -y install \
    zsh \
	code \
	git \
	procps \
	libasound2 \
	libatk1.0-0 \
	libcairo2 \
	libcups2 \
	libexpat1 \
	libfontconfig1 \
	libfreetype6 \
	libgtk2.0-0 \
	libpango-1.0-0 \
	libx11-xcb1 \
	libxcomposite1 \
	libxcursor1 \
	libxdamage1 \
	libxext6 \
	libxfixes3 \
	libxi6 \
	libxrandr2 \
	libxrender1 \
	libxss1 \
	libxtst6 \
	openssh-client \
	libxcb-dri3-0 \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

COPY start.sh /usr/local/bin/start.sh
COPY local.conf /etc/fonts/local.conf

WORKDIR $HOME
USER app

ENTRYPOINT [ "/usr/local/bin/start.sh" ]
