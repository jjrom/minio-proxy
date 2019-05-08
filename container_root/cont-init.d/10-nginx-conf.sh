#!/usr/bin/with-contenv bash

CONF_NGINX_SITE=/etc/nginx/sites-available/default

if [[ ${MINIO_EXPOSED_PORT} ]]
then
  echo "[nginx] setting minio port to ${MINIO_EXPOSED_PORT}"
  sed -i "s/\minio:9000;/minio:${MINIO_EXPOSED_PORT};/" $CONF_NGINX_SITE
fi
