FROM ubuntu:18.04

ARG UID=1000
ARG GID=1000
ENV ICA_CLIENT_VERSION "13.6.0.10243651_amd64"
ENV HOME /home/app

LABEL MAINTAINER "Martin Buchleitner <mabunixda@gmail.com>"

COPY "icaclient_${ICA_CLIENT_VERSION}.deb" /tmp
RUN apt-get update \
    && apt-get install -y firefox \
                            xdg-utils \
                            libwebkitgtk-1.0-0 libxmu6 \
                            libxpm4 \
    && dpkg -i /tmp/icaclient_${ICA_CLIENT_VERSION}.deb \
    && rm /tmp/icaclient_${ICA_CLIENT_VERSION}.deb \
    && cd /opt/Citrix/ICAClient/keystore/cacerts/ \
    && ln -s /usr/share/ca-certificates/mozilla/* . \
    && c_rehash /opt/Citrix/ICAClient/keystore/cacerts/ \
    && xdg-mime default wfica.desktop application/x-ica

RUN useradd --create-home --home-dir $HOME --uid $UID  app \
	&& chown -R app: ${HOME}

USER app
WORKDIR ${HOME}
CMD /usr/bin/firefox -no-remote
