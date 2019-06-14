#!/usr/bin/env bash

JAVA="/usr/bin/java"
JVM_JAR="/usr/lib/unifi/lib/ace.jar"
JVM_MAX_MEM=${JVM_MAX_MEM:-512m}
JVM_DEFAULT_OPTS="-XX:NewRatio=50 -XX:+UseG1GC -XX:+UnlockExperimentalVMOptions -XX:+HeapDumpOnOutOfMemoryError -XX:-DisableExplicitGC -XX:+AggressiveOpts -Xnoclassgc -XX:+UseNUMA -XX:+UseFastAccessorMethods -XX:ReservedCodeCacheSize=48m -XX:+UseStringCache -XX:+UseStringDeduplication -XX:MaxGCPauseMillis=400 -XX:GCPauseIntervalMillis=8000"

JVM_EXTRA_OPTS=${JVM_EXTRA_OPTS}

JVM_OPTS="$JVM_DEFAULT_OPTS"
if [ ! -z "$JVM_EXTRA_OPTS}" ]; then
  JVM_OPTS="$JVM_OPTS $JVM_EXTRA_OPTS"
fi

$JAVA -d64 -server -Xmx${JVM_MAX_MEM} ${JVM_OPTS} -jar ${JVM_JAR} $@
