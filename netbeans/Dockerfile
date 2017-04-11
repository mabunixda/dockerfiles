FROM ubuntu:17.04

# Install X11 tools and those needed here for downloads.
RUN apt-get update && apt-get install -y \
	curl libxext-dev libxrender-dev libxtst-dev unzip wget \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* \
	&& rm -rf /tmp/*

ENV NETBEANS_URL=http://download.oracle.com/otn-pub/java/jdk-nb/8u71-8.1/jdk-8u71-nb-8_1-linux-x64.sh
ENV POLICY_URL=http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip
ENV COOKIE="Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie"

RUN wget --progress=bar:force $NETBEANS_URL -O /tmp/netbeans.sh \
        --no-cookies --no-check-certificate --header "$COOKIE" \
        && echo "Installing NetBeans $NETBEANS_VERSION..." \
        && chmod +x /tmp/netbeans.sh; sleep 1 \
        && /tmp/netbeans.sh --silent \
        && ln -s $(ls -d /usr/local/netbeans-*) /usr/local/netbeans \
        && rm -rf /tmp/*

# Download & install the unlimited strength policy jars
RUN curl -L $POLICY_URL -o /tmp/policy.zip \
		--cookie 'oraclelicense=accept-securebackup-cookie;' \
	&& JAVA_HOME=$(ls -d /usr/local/jdk1.*) \
        && unzip -j -o /tmp/policy.zip -d $JAVA_HOME/jre/lib/security \
	&& rm /tmp/policy.zip
# Make a user
ENV HOME /home/app
RUN useradd --create-home --home-dir $HOME --uid 1000 app \
	&& chown -R app:app $HOME
USER app
CMD /usr/local/netbeans/bin/netbeans
