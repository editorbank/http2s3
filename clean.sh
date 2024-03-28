docker rm -f http2s3_http2s3_1
docker rm -f http2s3_s3svr_1
docker rm -f http2s3
docker rmi -f editorbank/http2s3
docker rmi -f nginx:alpine
docker rmi -f scality/s3server