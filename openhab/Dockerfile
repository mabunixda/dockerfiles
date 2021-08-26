FROM docker.io/openhab/openhab:latest-debian

RUN wget -nv -O /tmp/ZuluJCEPolicies.zip http://cdn.azul.com/zcek/bin/ZuluJCEPolicies.zip \
    && unzip -j -o -d ${JAVA_HOME}/lib/security /tmp/ZuluJCEPolicies.zip \
    && rm -f /tmp/ZuluJCEPolicies.zip
