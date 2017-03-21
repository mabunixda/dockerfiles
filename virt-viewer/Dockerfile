FROM debian:stretch
LABEL maintainer "Martin Buchleitner <mabunixda@gmail.com>"

RUN apt-get update && apt-get install -y \
	libgl1-mesa-dri \
	libgl1-mesa-glx \
	virt-viewer \
	openssh-client \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

ENTRYPOINT   ["virt-viewer"]
CMD [ "-c", "qemu:///system"]