#!/usr/bin/env bash

JAVA="/usr/bin/java"
BASEDIR="/usr/lib/unifi"
DATADIR="${BASEDIR}/data"
LOGSDIR="${DATADIR}/logs"
RUNDIR="${DATADIR}/run"

MONGOPORT=27117
MONGOLOCK="${DATADIR}/db/mongod.lock"
JVM_JAR="${BASEDIR}/lib/ace.jar"
JVM_MAX_MEM=${JVM_MAX_MEM:-1024m}
JVM_OPTS="-XX:NewRatio=50 -XX:+UseG1GC -XX:+UnlockExperimentalVMOptions -XX:+HeapDumpOnOutOfMemoryError -XX:-DisableExplicitGC -XX:+AggressiveOpts -Xnoclassgc -XX:+UseNUMA "
JVM_OPTS="${JVM_OPTS} -XX:+UseFastAccessorMethods -XX:+UseStringDeduplication -XX:MaxGCPauseMillis=400 -XX:GCPauseIntervalMillis=8000"
JVM_OPTS="${JVM_OPTS} -Dunifi.datadir=${DATADIR} -Dunifi.logdir=${LOGSDIR} -Dunifi.rundir=${RUNDIR}"

if [ ! -z "$JVM_EXTRA_OPTS}" ]; then
  JVM_OPTS="$JVM_OPTS $JVM_EXTRA_OPTS"
fi

confFile="${DATADIR}/system.properties"

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

mkdir -p "${LOGSDIR}"
rm -rf "${BASEDIR}/logs"
ln -sf "${LOGSDIR}" "${BASEDIR}/logs"

$JAVA -Xmx${JVM_MAX_MEM} ${JVM_OPTS} -jar ${JVM_JAR} $@
