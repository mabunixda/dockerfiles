FROM java:8-jdk

LABEL maintainer "Martin Buchleitner <mabunixda@gmail.com>"

ENV HOME /build

RUN apt-get -yqq update \
    && apt-get -yqq install apt-transport-https screen bash vim less \
    && echo "deb https://packages.atlassian.com/atlassian-sdk-deb stable contrib" >>/etc/apt/sources.list \
    && wget https://packages.atlassian.com/api/gpg/key/public  \
    && apt-key add public \
    && apt-get -yqq update \
    && apt-get -yqq install atlassian-plugin-sdk nginx-full \
    && mkdir -p $HOME \
    && useradd --create-home --home-dir $HOME app \
    && chown -R app:app $HOME

ADD atlassian-sdk.sh /etc/profile.d/atlassian-sdk.sh
ADD ssl.sh /usr/local/bin/ssl.sh
ADD nginx.conf /etc/nginx/nginx.conf

USER app
# Create directory for sources using the same practice as the ruby images
WORKDIR /build

# Set the default running command of the AMPS image to be running the
# application in debug mode.
CMD ["bash"]
