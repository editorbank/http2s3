#!
set -e
echo Create buckets ...
./bin/s3curl.sh PUT /mybucket
./bin/s3curl.sh PUT /other-bucket
echo Buckets list through proxy ...
curl  --fail-with-body -sD- http://localhost:8001$1 | sed 's/<Bucket>/\n<Bucket>/g' && echo -e "\nOK" || (echo -e "\nFAIL" ; exit 1)
