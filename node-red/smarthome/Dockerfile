FROM nodered/node-red
EXPOSE 1880/tcp
USER root

COPY package.json /usr/src/node-red/
RUN npm install
USER node-red

