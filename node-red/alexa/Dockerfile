FROM nodered/node-red:latest-12-minimal
USER root
COPY package.json /usr/src/node-red/package-patch.json
RUN awk -F':' '{system("npm install "$1)}' package-patch.json \
  && rm /usr/src/node-red/package-patch.json
USER node-red
