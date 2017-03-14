#!/bin/bash

if [ ! -f "/config/JDownloader.jar" ]; then
    cp /usr/local/bin/JDownloader.jar $HOME
fi

java -Djava.awt.headless -jar $HOME/JDownloader.jar &

while true;
do
   pid=$(pgrep -n java)
   if [ -z "$pid" ]; then
	break;
   fi
   sleep 1m
done
