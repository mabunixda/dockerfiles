ARG JENKINS_VERSION=2.347-alpine
FROM docker.io/jenkins/jenkins:$JENKINS_VERSION

USER root
RUN apk add --no-cache jq

USER jenkins

COPY custom/ /usr/share/jenkins/ref/
RUN jenkins-plugin-cli --verbose -f /usr/share/jenkins/ref/plugins.txt
