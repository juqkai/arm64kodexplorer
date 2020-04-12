FROM php:7.3.6-zts-alpine3.9
LABEL maintainer="xaljer@outlook.com"

ARG KODEXPLORER_VERSION=4.40
ARG KODEXPLORER_URL="https://github.com/kalcaddle/KodExplorer/archive/${KODEXPLORER_VERSION}.tar.gz"

RUN set -x \
  && mkdir -p /usr/src/kodexplorer \
  && apk --update --no-cache add wget bash \
  && wget -q -O /tmp/kodexplorer.tar.gz "$KODEXPLORER_URL" \
  && tar -xzf /tmp/kodexplorer.tar.gz -C /usr/src/kodexplorer/ --strip-components=1 \
  && rm -rf /tmp/*

RUN set -x \
  && apk add --no-cache --update \
        freetype libpng libjpeg-turbo \
        freetype-dev libpng-dev libjpeg-turbo-dev \
        php7-exif \
  && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
  && docker-php-ext-install -j "$(getconf _NPROCESSORS_ONLN)" gd \
  && docker-php-ext-install exif \
  && apk del --no-cache freetype-dev libpng-dev libjpeg-turbo-dev

WORKDIR /var/www/html

COPY entrypoint.sh /usr/local/bin/
RUN chmod a+x /usr/local/bin/entrypoint.sh

EXPOSE 80

ENTRYPOINT ["entrypoint.sh"]
CMD [ "php", "-S", "0000:80", "-t", "/var/www/html" ]

