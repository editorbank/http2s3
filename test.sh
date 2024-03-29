#!
set -e
echo Create buckets ...
./s3cli.sh PUT /mybucket
./s3cli.sh PUT /other-bucket
echo Buckets list through proxy ...
curl  --fail-with-body -sD- http://localhost:81$1 | sed 's/<Bucket>/\n<Bucket>/g' && echo -e "\nOK" || (echo -e "\nFAIL" ; exit 1)
