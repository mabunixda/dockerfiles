#!/bin/bash
mkdir /etc/nginx/ssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt
keytool -import -trustcacerts -alias nginx -file /etc/nginx/ssl/nginx.crt -keystore /usr/lib/jvm/java-1.8.0-openjdk-amd64/jre/lib/security/cacerts

nginx
