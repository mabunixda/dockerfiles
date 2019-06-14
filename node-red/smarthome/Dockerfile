FROM nodered/node-red-docker:slim-v8
USER root

USER node-red
COPY package.json /usr/src/node-red/
RUN npm install

