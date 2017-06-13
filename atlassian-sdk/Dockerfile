FROM java:8-jdk

LABEL maintainer "Martin Buchleitner <mabunixda@gmail.com>"

ARG SDK_VERSION=6.2.14
ENV HOME /build

RUN apt-get -yqq update \
    && apt-get -yqq install apt-transport-https screen bash vim less \
    && echo "deb http://sdkrepo.atlassian.com/debian/ stable contrib" >>/etc/apt/sources.list \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B07804338C015B73 \
    && apt-get -yqq update \
    && apt-get -yqq install atlassian-plugin-sdk=$SDK_VERSION \
    && mkdir -p $HOME \
    && useradd --create-home --home-dir $HOME app \
    && chown -R app:app $HOME

ADD atlassian-sdk.sh /etc/profile.d/atlassian-sdk.sh

USER app
# Create directory for sources using the same practice as the ruby images
WORKDIR /build

# Set the default running command of the AMPS image to be running the
# application in debug mode.
CMD ["bash"]
