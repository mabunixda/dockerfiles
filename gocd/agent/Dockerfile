FROM ubuntu:17.10


RUN apt-get update \
    && apt-get install -y curl apt-transport-https software-properties-common \
    && echo "deb https://download.gocd.org /" > /etc/apt/sources.list.d/gocd.list \
    && curl https://download.gocd.org/GOCD-GPG-KEY.asc | apt-key add - \
    && apt-get update \
    && apt-get install -y openjdk-8-jdk \
    && apt-get install -y go-agent

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - \
    && add-apt-repository \
            "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
            $(lsb_release -cs) \
            stable" \
    && apt-get update \
    && apt-get install -y docker-ce git \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV GO_SERVER_URL ""

ENTRYPOINT [ "/usr/share/go-agent/agent.sh" ]
