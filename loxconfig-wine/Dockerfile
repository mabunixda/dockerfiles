FROM wine
MAINTAINER Martin Buchleitner <mabunixda@gmail.com>

WORKDIR /tmp

RUN apt-get update && apt-get install -y \
	curl ca-certificates unzip \
	--no-install-recommends \
	&& curl -o loxone-config.zip https://www.loxone.com/dede/wp-content/uploads/sites/2/2016/11/Loxone-Config-8.1.zip \
    && unzip loxone-config.zip \
    && mv Loxone-Config-8.1.exe /usr/src/Loxone-Config-8.1.exe \
    && rm -rf * \
	&& rm -rf /var/lib/apt/lists/* \
    && echo "wine /usr/src/Loxone-Config-8.1.exe" > /root/.bash_history

WORKDIR /root


CMD ["bash"]