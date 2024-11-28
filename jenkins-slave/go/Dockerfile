ARG GO_VERSION=1.21

FROM docker:latest AS docker

FROM golang:$GO_VERSION

COPY --from=docker /usr/local/bin/docker /usr/local/bin/docker
