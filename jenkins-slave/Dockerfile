FROM docker.io/java:openjdk-8-jdk-alpine

RUN apk add --no-cache git curl zip unzip bash ttf-dejavu openssh-client \
    && mkdir -p /var/run/sshd /var/lib/jenkins/workspace \
    && curl -fOL "https://releases.hashicorp.com/terraform/1.0.8/terraform_1.0.8_linux_amd64.zip" \
    && unzip -o terraform_1.0.8_linux_amd64.zip -d /usr/local/bin/ \
    && rm -rf terraform_1.0.8_linux_amd64.zip

COPY . /var/lib/jenkins/

WORKDIR /var/lib/jenkins
CMD /var/lib/jenkins/entrypoint.sh