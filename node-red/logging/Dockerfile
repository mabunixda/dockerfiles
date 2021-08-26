FROM docker.io/nodered/node-red:latest-14-minimal

USER root
COPY package.json /usr/src/node-red/package-patch.json
RUN apk add --no-cache git \
  && npm install -g npm

RUN awk -F':' '{system("npm install "$1)}' package-patch.json \
  && rm /usr/src/node-red/package-patch.json

# && npm install
USER node-red
