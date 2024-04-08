#!/bin/env bash
set -e

# Read config files ...
. "$(dirname $0)/prop.sh" prop_export S3_PROTOCOL S3_HOST S3_PORT S3_ACCESS_KEY S3_SECRET_KEY -f --env ./s3curl.properties ~/s3curl.properties "$(dirname $0)/s3curl.properties"

# Check settings ...
[ -z "${S3_ACCESS_KEY}" -o -z "${S3_SECRET_KEY}" ] && ( 1>&2 echo "ERROR: Undefined S3_ACCESS_KEY or S3_SECRET_KEY!" ; exit 1 )

S3_PROTOCOL="${S3_PROTOCOL:-http}"
[ "${S3_PROTOCOL}" == "http" -a -z "${S3_PORT}" ] && S3_PORT="80" || true
[ "${S3_PROTOCOL}" == "https" -a -z "${S3_PORT}" ] && S3_PORT="443" || true
S3_HOST="${S3_HOST:-localhost}"

method="${1:-GET}" 
resource="${2:-/}"
data="$3"
content_type="${4:-text/plain}"

# Do ...
date_time=$(date -R)
signed_text="${method}\n\n${content_type}\n${date_time}\n${resource}"
signature=$(echo -en "${signed_text}" | openssl sha1 -hmac ${S3_SECRET_KEY} -binary | base64)
url="${S3_PROTOCOL}://${S3_HOST}:${S3_PORT}${resource}"

[ -n "$data" ] && add_data=" --data-raw \"$data\"" || true
1>&2 echo "${method} ${url} ${add_data:0:30} ..."

curl --connect-timeout 10 --fail-with-body -ks ${url} \
 -X ${method} \
 -H "Host: ${S3_HOST}" \
 -H "Content-Type: ${content_type}" \
 -H "Date: ${date_time}" \
 -H "Authorization: AWS ${S3_ACCESS_KEY}:${signature}" \
 $add_data && ( 1>&2 echo -e "\nOK" ) || ( 1>&2 echo -e "\nFAIL" ; exit 1)
