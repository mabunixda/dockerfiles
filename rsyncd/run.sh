#!/usr/bin/env sh

ssh-keygen -A
sed -i s/$REMOTE_USERNAME:!/"$REMOTE_USERNAME:*"/g /etc/shadow

exec runsvdir /etc/rservice