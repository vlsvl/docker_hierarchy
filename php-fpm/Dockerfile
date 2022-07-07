# пробросить версию PHP из файла phpVersion.txt
ARG PHP_VERSION=7.4
ARG IMAGE_VERSION=default

# выбран образ на основе Debian, а не alpine, т.к. в Альпе нет многих либ для PHP
# еще можно будет попробовать вариант с buster
FROM php:${PHP_VERSION}-fpm-bullseye

LABEL maintainer="denis.golitsinsky@isbc.com"
LABEL image_version=${IMAGE_VERSION}

ARG UID_GID=1001
ENV UID=${UID_GID}
ENV GID=${UID_GID}

# add group grnode add user usnode with UID 1001
RUN groupadd --gid $UID appuser \
  && useradd --uid $UID --gid appuser --shell /bin/bash --create-home appuser
RUN chown -R appuser:appuser /var/www && chmod -R 755 /var/www

# установить инструменты дебага
RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    net-tools \
    telnet \
    htop \
    mc

# дальнейшие действия выполняем под созданным non-root пользователем
#USER $UID
USER appuser

EXPOSE 9000
