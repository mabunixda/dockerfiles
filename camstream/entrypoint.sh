#!/usr/bin/env bash

for f in $(ls /var/www/cgi-bin/*.tpl); do
    cat $f | envsubst > "$(dirname $f)/$(basename $f ".tpl")"
done
chmod +x /var/www/cgi-bin/*
lighttpd -D -f /etc/lighttpd/lighttpd.conf