FROM nodered/node-red-docker:slim-v8

USER root
RUN apk add --no-cache git
USER node-red
COPY package.json /usr/src/node-red/
RUN npm install
