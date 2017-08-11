FROM debian:jessie as builder

WORKDIR /tmp

ENV ECLIPSE_URL https://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/oxygen/R/eclipse-jee-oxygen-R-linux-gtk-x86_64.tar.gz&r=1
RUN set -x \
    && apt-get update \
    && apt-get install -y curl \
    && curl -sSL  $ECLIPSE_URL  -o /tmp/eclipse.tar.gz\
    && tar xfz eclipse.tar.gz


FROM debian:unstable
LABEL maintainer="Martin Buchleitner <mabunixda@gmail.com>"

ENV HOME /home/app

RUN set -x \
	&& useradd --create-home --home-dir $HOME app \
	&& chown -R app:app $HOME \
    && apt-get update \
    && apt-get install -y openjdk-8-jdk \
  	&& rm -rf /var/lib/apt/lists/* 

COPY --from=builder /tmp/eclipse/ /opt/eclipse/
WORKDIR $HOME
USER app

CMD [ "/opt/eclipse/eclipse" ]
