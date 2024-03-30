podman-compose kill
podman-compose down
podman rmi -f docker.io/editorbank/http2s3
podman rmi -f docker.io/library/nginx:alpine
podman rmi -f docker.io/scality/s3server
podman network exists http2s3_default && podman network rm -f http2s3_default
rm -fr ./.tmp