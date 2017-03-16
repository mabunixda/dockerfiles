#!/bin/bash

if [ ! -f "$HOME/JDownloader.jar" ]; then
    cp /usr/src/JDownloader.jar $HOME
fi

java -Djava.awt.headless -jar $HOME/JDownloader.jar &

localport=$(grep "localhttpport" ~/.jdownloader2/cfg/*.json | awk -F': ' '{print $3}'  | sed 's/,//')

mkfifo a
mkfifo b
nc 127.0.0.1 $localport < b > a &
nc -l $localport < a > b & 

while true;
do
   pid=$(pgrep -n java)
   if [ -z "$pid" ]; then
    exit 0;
   fi
   sleep 1m
done
