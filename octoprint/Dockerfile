FROM resin/raspberrypi3-alpine-python
EXPOSE 5000
LABEL maintainer "mabunixda@gmail.com"

ENV CURA_VERSION=15.04.6
ARG tag=master
ARG UID=1000

WORKDIR /tmp
# In case of alpinRUN
RUN apk add --no-cache bash git \
    && apk add --no-cache --virtual .build-deps g++ gcc  libexecinfo-dev make linux-headers \
    && pip install virtualenv \
	&& rm -rf /var/cache/apk/*

#install ffmpeg
RUN wget -q -O ffmpeg.tar.xz https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-32bit-static.tar.xz \
	&& mkdir -p /opt/ffmpeg \
	&& tar xf ffmpeg.tar.xz -C /opt/ffmpeg --strip-components=1 \
  && rm -Rf /tmp/*

#install Cura
RUN wget -q -O Cura.tar.gz https://github.com/Ultimaker/CuraEngine/archive/${CURA_VERSION}.tar.gz \
  && tar -zxf Cura.tar.gz \
	&& cd CuraEngine-${CURA_VERSION} \
	&& mkdir build \
	&& make \
	&& mv -f ./build /opt/cura/ \
  && rm -Rf /tmp/*

#Create an octoprint user
RUN adduser -D -u $UID -s /bin/bash octoprint \
	  && adduser octoprint dialout \
          && adduser octoprint tty \
    && mkdir -p /opt/octoprint /octoprint \
    && chown octoprint:octoprint /opt/octoprint 

#RUN apk del .build-deps

USER octoprint
VOLUME /home/octoprint/.octoprint
WORKDIR /opt/octoprint
#Install Octoprint
RUN git clone --branch $tag https://github.com/foosel/OctoPrint.git /opt/octoprint \
  && virtualenv venv \
  && ./venv/bin/python setup.py install

ADD plugins.txt /tmp

RUN for p in $(cat /tmp/plugins.txt); do ./venv/bin/pip install $p; done
RUN ln -sf /home/octoprint/.octoprint/klipper_config/printer.cfg /home/octoprint/printer.cfg
USER root
RUN apk add --no-cache socat
USER octoprint 
ENTRYPOINT ["/opt/octoprint/venv/bin/octoprint"]
CMD [ "serve"]
