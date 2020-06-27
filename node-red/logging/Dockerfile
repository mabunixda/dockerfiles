FROM nodered/node-red:latest-12-minimal

USER root
COPY package.json /usr/src/node-red/package-patch.json
RUN apk add --no-cache git \
  && npm install -g npm

RUN for l in $(cat package-patch.json); do echo $l | awk -F':' '{system("npm install "$1"@"$2)}' ; done

# && npm install
USER node-red
