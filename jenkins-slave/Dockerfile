FROM docker.io/adoptopenjdk/openjdk8:jre

RUN apt-get update \
    && apt-get install -y git curl zip unzip bash ttf-dejavu openssh-client \
        apt-transport-https ca-certificates gnupg lsb-release \
    && mkdir -p /var/run/sshd /var/lib/jenkins/workspace \
    && curl -L https://raw.githubusercontent.com/warrensbox/terraform-switcher/release/install.sh | bash \
    && tfswitch -u

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list \
    && apt-get update \
    && apt-get install -y docker-ce docker-ce-cli containerd.io


COPY . /var/lib/jenkins/

WORKDIR /var/lib/jenkins
CMD /var/lib/jenkins/entrypoint.sh