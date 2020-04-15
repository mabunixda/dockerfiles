FROM python:2-alpine

ADD *.patch /

RUN apk add --no-cache --virtual .deps curl  \
  && curl -LO https://raw.githubusercontent.com/sarnau/Inside-The-Loxone-Miniserver/master/Code/LoxoneWeather.py \
  && apk del .deps \
  && patch LoxoneWeather.py LoxoneWeather_env.patch \
  && rm -rf LoxoneWeather_env.patch \
  && pip install requests \
  && chmod +x LoxoneWeather.py

EXPOSE 6066

ENTRYPOINT [ "/LoxoneWeather.py" ]