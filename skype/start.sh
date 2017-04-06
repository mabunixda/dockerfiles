#!/bin/bash

/usr/bin/skypeforlinux
while true;
do
   pid=$(pgrep -n skypeforlinux)
   if [ -z "$pid" ]; then
    exit 0
   fi
   sleep 15s
done
