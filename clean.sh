set -xe
docker=${1:-docker}
network_name=http2s3_network

${docker} ps -q -f "name=$(basename $PWD)_" | xargs -r ${docker} rm -f

${docker} images -q editorbank/http2s3:latest | xargs -r ${docker} rmi -f
${docker} images -q nginx:alpine              | xargs -r ${docker} rmi -f
${docker} images -q scality/s3server:latest   | xargs -r ${docker} rmi -f
${docker} network ls -q -f name=${network_name} | xargs -r ${docker} network rm -f
rm -fr ./.tmp
echo OK