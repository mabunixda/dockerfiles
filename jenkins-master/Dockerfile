ARG JENKINS_VERSION=2.314
FROM docker.io/jenkins/jenkins:$JENKINS_VERSION

USER root
RUN apt-get update \
    && apt-get install -y jq  \
	&& rm -rf /var/lib/apt/lists/*

USER jenkins

COPY custom/ /usr/share/jenkins/ref/
RUN jenkins-plugin-cli --verbose -f /usr/share/jenkins/ref/plugins.txt
