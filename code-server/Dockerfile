FROM debian:11
ARG VERSION=3.12.0

RUN apt-get update \
    && apt-get install -y curl dumb-init openssh-client sudo procps \
                          python3 python3-pip podman make zsh git gnupg2 tmux unzip \
                          apt-transport-https ca-certificates lsb-release

RUN curl -L https://raw.githubusercontent.com/warrensbox/terraform-switcher/release/install.sh | bash

RUN curl -fOL https://github.com/cdr/code-server/releases/download/v${VERSION}/code-server_${VERSION}_amd64.deb \
    && dpkg -i code-server_${VERSION}_amd64.deb \
    && rm code-server_${VERSION}_amd64.deb \
    && adduser --gecos '' --disabled-password coder \
    && echo "coder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/nopasswd \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL "https://github.com/boxboat/fixuid/releases/download/v0.5.1/fixuid-0.5.1-linux-amd64.tar.gz" | tar -C /usr/local/bin -xzf - \
    && chown root:root /usr/local/bin/fixuid \
    && chmod 4755 /usr/local/bin/fixuid \
    && mkdir -p /etc/fixuid \
    && printf "user: coder\ngroup: coder\n" > /etc/fixuid/config.yml

RUN curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpgecho \
    && echo "deb https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list \
    && apt-get update \
    && apt-get install -y docker-ce docker-ce-cli containerd.io \
    && rm -rf /var/lib/apt/lists/*

VOLUME /var/lib/containers

EXPOSE 8080/tcp

ADD entrypoint.sh /usr/bin/
ADD https://raw.githubusercontent.com/containers/libpod/master/contrib/podmanimage/stable/containers.conf /etc/containers/containers.conf

RUN echo coder:100000:65536 > /etc/subuid; \
    echo coder:100000:65536 > /etc/subgid; \
    mkdir -p /home/coder/.local/share/containers; \
    chmod 0644 /etc/containers/containers.conf

USER coder
WORKDIR /home/coder

ENTRYPOINT ["/usr/bin/entrypoint.sh", "--bind-addr", "0.0.0.0:8080", "."]