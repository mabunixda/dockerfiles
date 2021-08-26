FROM debian:buster

RUN apt-get update -q \
    && apt-get install -y apt-transport-https curl gnupg2 \
    && curl https://apt.homegear.eu/Release.key | apt-key add - \
    && echo 'deb https://apt.homegear.eu/Debian/ buster/' > /etc/apt/sources.list.d/homegear.list  \
    && apt-get update -q \
    && apt-get install -y homegear homegear-management homegear-nodes-core homegear-nodes-extra homegear-homematicbidcos homegear-homematicwired homegear-insteon homegear-max homegear-philipshue homegear-sonos homegear-kodi homegear-ipcam homegear-beckhoff homegear-knx homegear-enocean homegear-intertechno homegear-nanoleaf homegear-ccu homegear-mbus homegear-influxdb

ENTRYPOINT [ "homegear" ]