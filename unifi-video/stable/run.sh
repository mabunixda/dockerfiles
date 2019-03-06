#!/bin/bash

DATADIR=${DATADIR:-/var/lib/unifi-video}
BASEDIR="/usr/lib/unifi-video"

if [ ! -f "${DATADIR}/system.properties" ]; then
	cp ${BASEDIR}/etc/system.properties ${DATADIR}
	cp ${BASEDIR}/etc/ufv-truststore ${DATADIR}
fi
if [ ! -d "${DATADIR}/videos" ]; then
	mkdir -p "${DATADIR}/videos"
	mkdir -p "${DATADIR}/logs"
fi
ln -sf ${BASEDIR}/data ${DATADIR}

echo "Starting using ${DATADIR}..."

exec java  -cp /usr/lib/unifi-video/lib/airvision.jar  \
	-Djava.security.egd=file:/dev/urandom \
	-Xmx512M \
	-XX:+HeapDumpOnOutOfMemoryError \
	-XX:+UseG1GC \
	-XX:+UseStringDeduplication \
	-Djava.library.path=${BASEDIR}/lib \
	-Djava.awt.headless=true \
	-Djavax.net.ssl.trustStore=${DATADIR}/ufv-truststore \
	-Dfile.encoding=UTF-8 \
	com.ubnt.airvision.Main \
	start
