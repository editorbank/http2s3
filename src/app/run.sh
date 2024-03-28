#!/usr/bin/sh
set -ex
export IN_PORT=${IN_PORT:-8000}
export S3_PROTOCOL=${S3_PROTOCOL:-http}
export S3_HOST=${S3_HOST:-localhost}
export S3_PORT=${S3_PORT:-80}
export S3_PATH=${S3_PATH:-/}
envsubst '$IN_PORT,$S3_PROTOCOL,$S3_HOST,$S3_PORT,$S3_PATH' </app/nginx.conf >/tmp/nginx.conf
/usr/sbin/nginx -t -c /tmp/nginx.conf && /usr/sbin/nginx -c /tmp/nginx.conf