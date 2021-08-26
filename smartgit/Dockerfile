FROM docker.io/adoptopenjdk/openjdk8:slim
ARG SMARTGIT_VER=20.1.3

RUN apt-get update \
    && apt-get install -y curl \
			git \
			libgtk-3-0  \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp/
RUN /bin/bash -c 'curl -O https://www.syntevo.com/downloads/smartgit/smartgit-${SMARTGIT_VER//\./_}.deb && \
    dpkg -i smartgit-${SMARTGIT_VER//\./_}.deb' && \
    rm -rf /tmp/* /var/tmp/*

# Add chrome user
RUN groupadd -r app && useradd -r -g app --uid 1000 app \
    && mkdir -p /home/app \
    && chown -R app:app /home/app

# Run Chrome as non privileged user
USER app

CMD ["/usr/share/smartgit/bin/smartgit.sh"]
