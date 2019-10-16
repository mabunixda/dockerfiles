FROM nodered/node-red:latest-12-minimal
USER ROOT
COPY package.json /usr/src/node-red/
RUN npm install
USER node-red
