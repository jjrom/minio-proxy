FROM bitnami/nginx:latest

FROM ubuntu:bionic
LABEL maintainer="jerome.gasperi@gmail.com"

ENV JUST_CONTAINERS_VERSION=1.22.1.0 \
    ARCH=amd64

# Add S6 supervisor (for graceful stop)
ADD https://github.com/just-containers/s6-overlay/releases/download/v${JUST_CONTAINERS_VERSION}/s6-overlay-${ARCH}.tar.gz /tmp/
RUN tar xzf /tmp/s6-overlay-${ARCH}.tar.gz -C /
ENTRYPOINT ["/init"]
CMD []

# Add ppa, curl and syslogd
RUN apt-get update && apt-get install -y software-properties-common curl inetutils-syslogd && \
    apt-add-repository ppa:nginx/stable -y && \
    apt-get update && apt-get install -y \
    nginx && \
    apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* && \
    mkdir -p /run/php && chmod -R 755 /run/php

# Copy NGINX service script
COPY ./container_root/start-nginx.sh /etc/services.d/nginx/run
RUN chmod 755 /etc/services.d/nginx/run

# Copy NGINX configuration
COPY ./container_root/etc/nginx /etc/nginx

# Copy run.d configuration
COPY ./container_root/cont-init.d /etc/cont-init.d
