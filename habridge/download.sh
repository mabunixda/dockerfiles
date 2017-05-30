#!/bin/bash

VERSION="$(curl -sX GET https://api.github.com/repos/bwssytems/ha-bridge/releases/latest | grep 'tag_name' | cut -d\" -f4)"
VERSION=${VERSION:1}
echo "Latest version on bwssystems github repo is" $VERSION

curl -sL -o /srv/ha-bridge-$VERSION.jar https://github.com/bwssytems/ha-bridge/releases/download/v"$VERSION"/ha-bridge-"$VERSION".jar

ln -sf /srv/ha-bridge-$VERSION.jar /srv/ha-bridge.jar
