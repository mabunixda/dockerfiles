FROM nodered/node-red:latest-12-minimal

USER root
RUN apk add --no-cache git
COPY package.json /usr/src/node-red/
RUN npm install
USER node-red
