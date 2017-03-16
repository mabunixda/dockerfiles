#!/bin/bash

/usr/bin/code "$@"

while true;
do
   pid=$(pgrep -n code)
   if [ -z "$pid" ]; then
    exit 0
   fi
   sleep 1m
done
