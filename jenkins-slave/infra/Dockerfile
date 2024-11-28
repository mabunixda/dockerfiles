
ARG TERRAFORM_VERSION=1.9.8
ARG MONDOO_VERSION=11.31.0
ARG PACKER_VERSION=1.11.2
ARG YQ_VERSION=4.44.5
ARG TERRAFORM_DOCS_VERSION=0.19.0
ARG TFLINT_VERSION=v0.54.0
ARG TFSEC_VERSION=v1.28
ARG VAULT_VERSION=1.18

FROM docker.io/hashicorp/packer:$PACKER_VERSION AS packer
FROM docker.io/mondoo/client:$MONDOO_VERSION AS mondoo
FROM docker.io/mikefarah/yq:$YQ_VERSION AS yq
FROM quay.io/terraform-docs/terraform-docs:$TERRAFORM_DOCS_VERSION AS tfdocs
FROM ghcr.io/terraform-linters/tflint:$TFLINT_VERSION AS tflint
FROM docker.io/aquasec/tfsec-alpine:$TFSEC_VERSION AS tfsec
FROM docker.io/hashicorp/vault:${VAULT_VERSION} AS vault
FROM docker.io/hashicorp/terraform:$TERRAFORM_VERSION AS tf

FROM docker.io/debian:latest

COPY --from=yq /usr/bin/yq /usr/local/bin/yq
COPY --from=mondoo /usr/local/bin/mondoo /usr/local/bin/mondoo
COPY --from=tfdocs /usr/local/bin/terraform-docs /usr/local/bin/terraform-docs
COPY --from=tflint /usr/local/bin/tflint /usr/local/bin/tflint
COPY --from=tfsec /usr/bin/tfsec /usr/local/bin/tfsec
COPY --from=vault /bin/vault /usr/local/bin/vault
COPY --from=tf /bin/terraform /usr/local/bin/terraform
COPY --from=packer /bin/packer /usr/local/bin/packer


RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-get update \
    && apt-get install -y git wget tar curl zip unzip bash openssh-client \
        apt-transport-https ca-certificates gnupg lsb-release jq \
    && rm -rf /var/lib/apt/lists/*        

RUN export VER=$(curl -H "Accept: application/vnd.github+json" https://api.github.com/repos/bitwarden/clients/releases | jq  -r 'sort_by(.published_at) | reverse | .[].name | select( index("CLI") )' | sed 's:.*CLI v::' | head -n 1) && \
  curl -LO "https://github.com/bitwarden/clients/releases/download/cli-v{$VER}/bw-linux-{$VER}.zip" \
  && unzip *.zip \
  && chmod +x ./bw  \
  && mv ./bw /usr/local/bin \
  && rm bw*.zip