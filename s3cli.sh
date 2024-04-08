#!/bin/env bash
set -e

######## used functions from https://github.com/editorbank/prop

function prop_value(){
  sed -n -r "s/^[ \t]*($1)[ \t]*=[ \t]*([\']([^\']+)[\']|[\"]([^\"]+)[\"]|([^ \t\'\"\r]+)|([^ \t\'\"\r]+([ \t]+[^ \t\'\"\r]+)+))[ \t\r]*$/\3\4\5\6/p"
}

function prop_from(){
  key=$1
  while [ -n "$2" ] ; do
    if [ "--env" = "$2" ] ; then
      value=$( env | prop_value $key )
    else
      value=$( [ -r "$2" ] && cat "$2" | prop_value $key || true )
    fi
    [ -n "$value" ] && break || true
    shift
  done
  echo $value
}

function prop_export(){
  keys=()
  froms=()
  prefix=""
  suffix=""
  mode="-k"
  # parse params
  while [ -n "$1" ] ; do
    case "$1" in
      "--prefix" ) prefix="$2" ; shift ;;
      "--suffix" ) suffix="$2" ; shift ;;
      "-k" ) mode="-k" ;;
      "-f" ) mode="-f" ;;
      *)
        case $mode in
          "-k" ) keys+=( "$1" ) ;;
          "-f" ) froms+=( "$1" ) ;;
        esac
        ;;
    esac
    shift
  done
  # do export
  for key in "${keys[@]}" ; do
     export $prefix$key$suffix="$( prop_from $key ${froms[@]} )"
  done
}
########

# Read config files ...
prop_export S3_PROTOCOL S3_HOST S3_PORT S3_ACCESS_KEY S3_SECRET_KEY -f --env "./s3cli.properties" "~/s3cli.properties" "$(dirname $0)/s3cli.properties"

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
