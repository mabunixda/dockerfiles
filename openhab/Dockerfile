FROM openhab/openhab:2.3.0-amd64-debian

RUN cd /tmp \
    && wget https://cdn.azul.com/zcek/bin/ZuluJCEPolicies.zip \
    && unzip -jo -d ${JAVA_HOME}/jre/lib/security /tmp/ZuluJCEPolicies.zip \
    && rm /tmp/ZuluJCEPolicies.zip
