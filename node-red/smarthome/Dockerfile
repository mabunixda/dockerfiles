FROM nodered/node-red:latest-12-minimal
EXPOSE 1880/tcp
USER root
RUN apk add --no-cache git
COPY package.json /usr/src/node-red/package-patch.json
RUN awk -F':' '{system("npm install "$1)}' package-patch.json \
  && rm /usr/src/node-red/package-patch.json
USER node-red

