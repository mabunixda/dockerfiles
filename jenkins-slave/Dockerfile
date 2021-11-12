FROM docker.io/adoptopenjdk/openjdk8:jre

ARG MONDOO_VERSION=5.13.0
ARG PACKAGE="mondoo_${MONDOO_VERSION}_linux_amd64.tar.gz"
ARG BASEURL="https://releases.mondoo.io/mondoo/${MONDOO_VERSION}"


RUN apt-get update \
    && apt-get install -y git wget tar curl zip unzip bash ttf-dejavu openssh-client \
        apt-transport-https ca-certificates gnupg lsb-release jq \
    && mkdir -p /var/run/sshd /var/lib/jenkins/workspace \
    && curl -L https://raw.githubusercontent.com/warrensbox/terraform-switcher/release/install.sh | bash \
    && tfswitch -u

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list \
    && apt-get update \
    && apt-get install -y docker-ce docker-ce-cli containerd.io

RUN wget --quiet --output-document=SHA256SUMS ${BASEURL}/checksums.linux.txt &&\
    wget --quiet --output-document=${PACKAGE} ${BASEURL}/${PACKAGE} &&\
    cat SHA256SUMS | grep "${PACKAGE}" | sha256sum -c - &&\
    tar -xzC /usr/local/bin -f ${PACKAGE} &&\
    /usr/local/bin/mondoo version &&\
    rm -f ${PACKAGE} SHA256SUMS

COPY . /var/lib/jenkins/

WORKDIR /var/lib/jenkins
CMD /var/lib/jenkins/entrypoint.sh