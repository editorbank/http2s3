#!/bin/bash  
#source $(dirname $0)/config.sh
 
S3_ACCESS_KEY="YOUR-ACCESS-KEY-HERE"
S3_SECRET_KEY="YOUR-SECRET-KEY-HERE"
S3_HOST="localhost"
S3_PORT=81
S3_PROTOCOL=http
#S3_URI="/mybucket/"
S3_URI="/"
 
set -e
s3_file="${1:-s3list.xml}"
content_type="application/xml"
date_time=$(date -R)
resource="${S3_URI}"
method="GET"
signed_text="${method}\n\n${content_type}\n${date_time}\n${resource}"
signature=$(echo -en "${signed_text}" | openssl sha1 -hmac ${S3_SECRET_KEY} -binary | base64)
url="${S3_PROTOCOL:-https}://${S3_HOST}:${S3_PORT:-443}${resource}"
echo "${method} file:${s3_file} url:${url} ..."
echo "Content-Type: ${content_type}"
echo "Date: ${date_time}"
echo "Authorization: AWS ${S3_ACCESS_KEY}:${signature}"
echo "---"
curl -kD- ${url} \
 -X ${method} \
 -H "Host: ${S3_HOST}" \
 -H "Content-Type: ${content_type}" \
 -H "Date: ${date_time}" \
 -H "Authorization: AWS ${S3_ACCESS_KEY}:${signature}" \
  && echo -e "\nOK" || (1>&2 echo -e "\nFAIL" ; exit 1)

