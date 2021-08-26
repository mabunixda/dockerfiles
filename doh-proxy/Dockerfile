FROM docker.io/python:3-alpine

ENV UPSTREAM_DNS="127.0.0.1"
ENV LISTEN_ADDRESS="127.0.0.1"

EXPOSE 8080

RUN apk add --no-cache gcc musl-dev

RUN python -m pip install --upgrade pip \
  && pip3 install doh-proxy

CMD doh-proxy \
  --upstream-resolver="${UPSTREAM_DNS}" \
  --certfile=/certs/fullchain.pem \
  --keyfile=/certs/privkey.pem