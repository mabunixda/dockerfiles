ARG VERSION=1.9
FROM hashicorp/terraform:${VERSION} as tf


FROM ubuntu:focal

WORKDIR /usr/local/bin

RUN apt update && apt install -y curl unzip libsecret-1-0 jq bash

RUN export VER=$(curl -H "Accept: application/vnd.github+json" https://api.github.com/repos/bitwarden/clients/releases | jq  -r .[4].name | sed 's:.*v::') && \
curl -LO "https://github.com/bitwarden/clients/releases/download/cli-v{$VER}/bw-oss-linux-{$VER}.zip" \
&& unzip *.zip && chmod +x ./bw \
&& rm *.zip

COPY --from=tf /bin/terraform /usr/local/bin/terraform



