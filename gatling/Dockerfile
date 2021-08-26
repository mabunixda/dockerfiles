# Gatling is a highly capable load testing tool.
#
# Documentation: http://gatling.io/docs/2.2.2/
# Cheat sheet: http://gatling.io/#/cheat-sheet/2.2.2

FROM docker.io/adoptopenjdk/openjdk8:slim

LABEL  MAINTAINER "Martin Buchleitner <mabunixda@gmail.com>"

# working directory for gatling
WORKDIR /opt

# gating version
ENV VERSION=3.3.1

 # install gatling
RUN apt-get update -q \
  && apt-get -qy install curl bash unzip fontconfig \
  && curl -o /tmp/gatling.zip \
        https://repo1.maven.org/maven2/io/gatling/highcharts/gatling-charts-highcharts-bundle/$VERSION/gatling-charts-highcharts-bundle-$VERSION-bundle.zip  \
  && unzip /tmp/gatling.zip -d /tmp \
  && mv /tmp/gatling-charts-highcharts-bundle-$VERSION /opt/gatling \
  && rm -rf /tmp/gatling.zip

# change context to gatling directory
WORKDIR  /opt/gatling

# set directories below to be mountable from host
VOLUME ["/opt/gatling/conf", "/opt/gatling/results", "/opt/gatling/user-files"]

# set environment variables
ENV PATH /opt/gatling/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV GATLING_HOME /opt/gatling

CMD ["gatling.sh"]
