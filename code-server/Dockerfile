FROM debian:11

ARG VERSION=3.12.0

RUN apt-get update \
    && apt-get install -y curl dumb-init openssh-client sudo procps \
                          python3 python3-pip podman make zsh git gnupg2 tmux unzip \
                          apt-transport-https ca-certificates lsb-release

RUN curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list \
    && apt-get update \
    && apt-get install -y docker-ce docker-ce-cli containerd.io

RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN curl -L https://raw.githubusercontent.com/warrensbox/terraform-switcher/release/install.sh | bash \
    && curl -fsSL https://code-server.dev/install.sh | sh -s -- --version "${VERSION}"

RUN groupmod -g 998 docker \
    && adduser --uid 1000 --gecos '' --disabled-password coder \
    && usermod -a -G docker coder \
    && echo "coder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/nopasswd

EXPOSE 8080/tcp

ADD entrypoint.sh /usr/bin/

USER coder
WORKDIR /home/coder

ENTRYPOINT ["/usr/bin/entrypoint.sh", "--bind-addr", "0.0.0.0:8080", "."]
