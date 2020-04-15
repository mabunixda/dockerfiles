#!/usr/bin/env bash

if [ ! -f "conf.json" ]; then
    echo "please mount /home/Shinobi/conf.json"
    exit 1
fi
if [ ! -f "super.json" ]; then
    echo "please mount /home/Shinobi/super.json"
    exit 1
fi
COMPONENT="$1"
shift
if [ -z "$COMPONENT" ]; then
    echo "you must specify argument camera.js|cron.js"
    exit 1
fi
pm2 start $COMPONENT

trap : TERM INT; sleep infinity & wait