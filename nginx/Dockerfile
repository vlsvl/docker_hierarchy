# пробросить версию Nginx из файла nginxVersion.txt
ARG NGINX_VERSION=1.20.1
ARG IMAGE_VERSION=default

# образ из public repository
FROM nginx:${NGINX_VERSION}-alpine

LABEL maintainer="denis.golitsinsky@isbc.com"
LABEL image_version=${IMAGE_VERSION}
 
ARG UID_GID=1001
ENV UID=${UID_GID}
ENV GID=${UID_GID}

# добавление группы и user appuser с UID 1001 и предоствление прав на директории
RUN addgroup -g $GID -S appuser && adduser -u $UID -S appuser -G appuser
RUN mkdir /var/logs && chown -R appuser:appuser /var/logs

# обход прокси
RUN sed -i 's/https/http/g' /etc/apk/repositories && \
    apk update && \
    apk upgrade

# установить netstat, telnet, ca-certificates, curl
RUN apk add \
    bash \
    busybox-extras \
    ca-certificates \
    curl \
    && rm -rf /var/cache/apk/*

# дальнейшие действия выполняем под созданным non-root пользователем
USER appuser