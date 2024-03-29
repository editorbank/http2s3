docker-compose kill
docker-compose rm -f
docker rmi -f editorbank/http2s3
docker rmi -f docker.io/library/nginx:alpine
docker rmi -f scality/s3server
rm -fr ./.tmp