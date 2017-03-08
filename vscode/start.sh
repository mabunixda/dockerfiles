#!/bin/bash

/usr/bin/code "$@"

while true;
do
   pid=$(pgrep -n code)
   if [ -z "$pid" ]; then
	break;
   fi
   sleep 1m
done
