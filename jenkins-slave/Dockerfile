ARG AGENT_VERSION=latest

ARG TERRAFORM_VERSION=1.5.7
ARG MONDOO_VERSION=9.0.2
ARG PACKER_VERSION=1.9.4
ARG YQ_VERSION=4.35.2
ARG TERRAFORM_DOCS_VERSION=latest
ARG TFLINT_VERSION=latest
ARG TFSEC_VERSION=latest
ARG VAULT_VERSION=1.15.1

FROM docker.io/hashicorp/packer:$PACKER_VERSION as packer
FROM docker.io/mondoo/client:$MONDOO_VERSION as mondoo
FROM docker.io/mikefarah/yq:$YQ_VERSION as yq
FROM quay.io/terraform-docs/terraform-docs:$TERRAFORM_DOCS_VERSION as tfdocs
FROM ghcr.io/terraform-linters/tflint:$TFLINT_VERSION as tflint
FROM docker.io/aquasec/tfsec-alpine:$TFSEC_VERSION as tfsec
FROM docker.io/hashicorp/vault:${VAULT_VERSION} as vault
FROM docker.io/hashicorp/terraform:$TERRAFORM_VERSION as tf

FROM docker.io/jenkins/inbound-agent:${AGENT_VERSION}

COPY --from=yq /usr/bin/yq /usr/local/bin/yq
COPY --from=mondoo /usr/local/bin/mondoo /usr/local/bin/mondoo
COPY --from=tfdocs /usr/local/bin/terraform-docs /usr/local/bin/terraform-docs
COPY --from=tflint /usr/local/bin/tflint /usr/local/bin/tflint
COPY --from=tfsec /usr/bin/tfsec /usr/local/bin/tfsec
COPY --from=vault /bin/vault /usr/local/bin/vault
COPY --from=tf /bin/terraform /usr/local/bin/terraform
COPY --from=packer /bin/packer /usr/local/bin/packer

USER root
RUN apt-get update \
    && apt-get install -y git wget tar curl zip unzip bash openssh-client \
        apt-transport-https ca-certificates gnupg lsb-release jq

# RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg \
#     && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
#   $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list \
#     && apt-get update \
#     && apt-get install -y docker-ce docker-ce-cli containerd.io

USER jenkins
