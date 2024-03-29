#!/bin/sh
set -e

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
export IN_PORT=${IN_PORT:-8000}
export S3_PROTOCOL=${S3_PROTOCOL:-http}
export S3_HOST=${S3_HOST:-localhost}
export S3_PORT=${S3_PORT:-80}
export S3_PATH=${S3_PATH:-/}
envsubst '$IN_PORT,$S3_PROTOCOL,$S3_HOST,$S3_PORT' </app/nginx.conf >/tmp/nginx.conf
exec $@