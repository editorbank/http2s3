#!
method="${1:-GET}" 
resource="${2:-/}"
data="$3"
content_type="${4:-plain/text}"

S3_PROTOCOL="${S3_PROTOCOL:-http}"
S3_HOST="${S3_HOST:-localhost}"
S3_PORT="${S3_PORT:-81}"
S3_ACCESS_KEY="${S3_ACCESS_KEY:-YOUR-ACCESS-KEY-HERE}"
S3_SECRET_KEY="${S3_SECRET_KEY:-YOUR-SECRET-KEY-HERE}"

set -e
date_time=$(date -R)
signed_text="${method}\n\n${content_type}\n${date_time}\n${resource}"
signature=$(echo -en "${signed_text}" | openssl sha1 -hmac ${S3_SECRET_KEY} -binary | base64)
url="${S3_PROTOCOL}://${S3_HOST}:${S3_PORT}${resource}"

[ -n "$data" ] && add_data=" --data-raw \"$data\"" || true
echo "${method} ${url} $add_data ..."

curl --fail-with-body -ks ${url} \
 -X ${method} \
 -H "Host: ${S3_HOST}" \
 -H "Content-Type: ${content_type}" \
 -H "Date: ${date_time}" \
 -H "Authorization: AWS ${S3_ACCESS_KEY}:${signature}" \
 $add_data  &&echo -e "\nOK" || (echo -e "\nFAIL" ; exit 1)
echo ""
