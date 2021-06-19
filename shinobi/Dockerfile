FROM ubuntu:groovy-20210614

ENV DEBIAN_FRONTEND="noninteractive"
ENV TZ=Europe/Vienna

RUN apt-get -qq update \
  && apt-get -yqq install sudo \
  wget  \
  git \
  software-properties-common \
  ffmpeg \
  dos2unix

RUN apt-get install -y curl

ENV productName="Shinobi Professional (Pro)"
ENV GITURL="https://gitlab.com/Shinobi-Systems/Shinobi"
ARG BRANCH="master"

RUN git clone $GITURL.git -b $BRANCH /home/Shinobi
WORKDIR /home/Shinobi

RUN grep -v -i mariadb INSTALL/ubuntu-touchless.sh | grep -v -i mysql > INSTALL/custom-inst.sh \
  && chmod +x INSTALL/custom-inst.sh \
  && ./INSTALL/custom-inst.sh \
  && rm ./INSTALL/custom-inst.sh \
  && rm -f conf.json super.json \
  && pm2 stop all
EXPOSE 8080

VOLUME ["/home/Shinobi/video"]

ADD entrypoint.sh /usr/local/bin

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
