FROM docker.io/archlinux:base-devel

ARG VERSION=4.0.1
ARG DUMBINIT_VERSION=1.2.5
RUN pacman -Syu --noconfirm git tmux unzip packer buildah zsh gnupg pacman-contrib sudo openssh buildah podman shadow vim rsync \
    && rm -fr /var/lib/pacman/sync/* \
    && useradd --uid 1000 coder \
    && echo "coder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/nopasswd

RUN curl -L https://raw.githubusercontent.com/warrensbox/terraform-switcher/release/install.sh | bash \
    && curl -fL -o /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v${DUMBINIT_VERSION}/dumb-init_${DUMBINIT_VERSION}_x86_64 \
    && chmod +x /usr/local/bin/dumb-init

EXPOSE 8080/tcp
ADD entrypoint.sh /usr/bin/

ADD https://raw.githubusercontent.com/containers/libpod/master/contrib/podmanimage/stable/containers.conf /etc/containers/containers.conf

# chmod containers.conf and adjust storage.conf to enable Fuse storage.
#
RUN chmod 644 /etc/containers/containers.conf \
    && sed -i -e 's/^driver=.*/driver="vfs"/' -e 's|^#mount_program|mount_program|g' -e '/additionalimage.*/a "/var/lib/shared",' -e 's|^mountopt[[:space:]]*=.*$|mountopt = "nodev,fsync=0"|g' /etc/containers/storage.conf \
    && mkdir -p /var/lib/shared/overlay-images /var/lib/shared/overlay-layers /var/lib/shared/vfs-images /var/lib/shared/vfs-layers; touch /var/lib/shared/overlay-images/images.lock; touch /var/lib/shared/overlay-layers/layers.lock; touch /var/lib/shared/vfs-images/images.lock; touch /var/lib/shared/vfs-layers/layers.lock \
    && touch /etc/subuid /etc/subgid \
    && usermod --add-subuids 200000-201000  coder \
    && usermod --add-subgids 200000-201000  coder

USER coder
# Install code-server from the AUR with plain makepkg.
RUN git clone https://aur.archlinux.org/code-server.git /tmp/code-server/ \
    && cd /tmp/code-server \
    && makepkg -si --noconfirm --noprogressbar \

#RUN git clone https://aur.archlinux.org/yay-git.git /tmp/yay/ \
#    && cd /tmp/yay \
#    && makepkg -si --noconfirm --noprogressbar \
#    && yay --no-confirm -Sy --devel google-chrome

RUN rm -rf /tmp/*

WORKDIR /home/coder

ENTRYPOINT ["/usr/bin/entrypoint.sh", "--bind-addr", "0.0.0.0:8080", "."]
