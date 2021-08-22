#!/bin/bash

RUNUSER=${RUNUSER:-unifi-video}
RUNGROUP=${RUNGROUP:-unifi-video}
DATADIR=${DATADIR:-/var/lib/unifi-video}
BASEDIR="/usr/lib/unifi-video"
JVM_MAX_MEM=${JVM_MAX_MEM:-512m}
MAINCLASS="com.ubnt.airvision.Main"
JVM_JAR="/usr/lib/unifi-video/lib/airvision.jar"
MONGOPORT=27117
MONGOLOCK="${DATADIR}/db/mongod.lock"

JVM_OPTS="-Djava.security.egd=file:/dev/urandom -Xmx${JVM_MAX_MEM} -XX:+HeapDumpOnOutOfMemoryError -XX:+UseG1GC "
JVM_OPTS="${JVM_OPTS} -XX:+UseStringDeduplication -Djava.library.path=${BASEDIR}/lib -Djava.awt.headless=true "
JVM_OPTS="${JVM_OPTS} -Djavax.net.ssl.trustStore=${DATADIR}/ufv-truststore -Dfile.encoding=UTF-8 "
confFile="${DATADIR}/system.properties"

if [ ! -f "$confFile" ]; then
	cp ${BASEDIR}/etc/system.properties ${DATADIR}
	cp ${BASEDIR}/etc/ufv-truststore ${DATADIR}
fi
if [ ! -d "${DATADIR}/videos" ]; then
	mkdir -p "${DATADIR}/videos"
	mkdir -p "${DATADIR}/logs"
fi


confSet () {
  file=$1
  key=$2
  value=$3

  if grep -q "^${key} *=" "$file"; then
    ekey=$(echo "$key" | sed -e 's/[]\/$*.^|[]/\\&/g')
    evalue=$(echo "$value" | sed -e 's/[\/&]/\\&/g')
    sed -i "s/^\(${ekey}\s*=\s*\).*$/\1${evalue}/" "$file"
  else
    echo "${key}=${value}" >> "$file"
  fi
}
declare -A settings
if ! [[ -z "$DB_URI" || -z "$STATDB_URI" || -z "$DB_NAME" ]]; then
  settings["db.mongo.local"]="false"
  settings["db.mongo.uri"]="$DB_URI"
  settings["statdb.mongo.uri"]="$STATDB_URI"
  settings["unifi.db.name"]="$DB_NAME"
fi

for key in "${!settings[@]}"; do
  confSet "$confFile" "$key" "${settings[$key]}"
done


exit_handler() {
    log "Exit signal received, shutting down"
    $JAVA -jar ${JVM_JAR} stop
    for i in `seq 1 10` ; do
        [ -z "$(pgrep -f ${JVM_JAR})" ] && break
        # graceful shutdown
        [ $i -gt 1 ] && [ -d ${BASEDIR}/run ] && touch ${BASEDIR}/run/server.stop || true
        # savage shutdown
        [ $i -gt 7 ] && pkill -f ${JVM_JAR} || true
        sleep 1
    done
    # shutdown mongod
    if [ -f ${MONGOLOCK} ]; then
        mongo localhost:${MONGOPORT} --eval "db.getSiblingDB('admin').shutdownServer()" >/dev/null 2>&1
    fi
    exit ${?};
}

trap 'kill ${!}; exit_handler' SIGHUP SIGINT SIGQUIT SIGTERM

echo "Starting using ${DATADIR}..."

exec runuser -p -u "$RUNUSER" -g "$RUNGROUP" -- java  -cp ${JVM_JAR} ${JVM_OPTS} ${MAINCLASS} $@
