FROM ubuntu:18.04


RUN apt-get update \
    && apt-get install -y curl apt-transport-https software-properties-common \
    && echo "deb https://download.gocd.org /" > /etc/apt/sources.list.d/gocd.list \
    && curl https://download.gocd.org/GOCD-GPG-KEY.asc | apt-key add - \
    && apt-get update \
    && apt-get install -y openjdk-8-jre \
    && apt-get install -y go-server git \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


ENV SERVER_WORK_DIR /data

RUN mkdir -p ${SERVER_WORK_DIR}
EXPOSE 8153 8154

VOLUME ["${SERVER_WORK_DIR}", "/etc/go" ]

ENTRYPOINT [ "/usr/share/go-server/server.sh" ]
