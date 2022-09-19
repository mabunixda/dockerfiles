ARG TERRAFORM_VERSION=1.2.4
ARG MONDOO_VERSION=6.6.0
ARG PACKER_VERSION=1.8.2
ARG YQ_VERSION=4.23.1

ARG VERSION=4.7.0
FROM docker.io/hashicorp/terraform:$TERRAFORM_VERSION as tf
FROM docker.io/mondoo/client:$MONDOO_VERSION as mondoo
FROM docker.io/mikefarah/yq:$YQ_VERSION as yq
FROM docker.io/hashicorp/packer:$PACKER_VERSION as packer


FROM docker.io/codercom/code-server:$VERSION

USER root

COPY --from=yq /usr/bin/yq /usr/local/bin/yq
COPY --from=mondoo /usr/local/bin/mondoo /usr/local/bin/mondoo
COPY --from=tf /bin/terraform /usr/local/bin/terraform
COPY --from=packer /bin/packer /usr/local/bin/packer

RUN apt-get update \
    && apt-get install -y \
    buildah \
    vim \
    make \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    && mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg \
    && echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
    $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list \
    && apt-get update \
    && apt-get install -y docker-ce-cli \
    && rm -rf /var/lib/apt/lists/*


# ADD https://raw.githubusercontent.com/containers/libpod/master/contrib/podmanimage/stable/containers.conf /etc/containers/containers.conf

# chmod containers.conf and adjust storage.conf to enable Fuse storage.
#
# RUN chmod 644 /etc/containers/containers.conf \
#     && sed -i -e 's/^driver=.*/driver="vfs"/' -e 's|^#mount_program|mount_program|g' -e '/additionalimage.*/a "/var/lib/shared",' -e 's|^mountopt[[:space:]]*=.*$|mountopt = "nodev,fsync=0"|g' /etc/containers/storage.conf \
#     && mkdir -p /var/lib/shared/overlay-images /var/lib/shared/overlay-layers /var/lib/shared/vfs-images /var/lib/shared/vfs-layers; touch /var/lib/shared/overlay-images/images.lock; touch /var/lib/shared/overlay-layers/layers.lock; touch /var/lib/shared/vfs-images/images.lock; touch /var/lib/shared/vfs-layers/layers.lock \
#     && touch /etc/subuid /etc/subgid \
#     && usermod --add-subuids 200000-201000  coder \
#     && usermod --add-subgids 200000-201000  coder

USER coder
WORKDIR /home/coder

ENTRYPOINT ["/usr/bin/entrypoint.sh", "--bind-addr", "0.0.0.0:8080", "."]
