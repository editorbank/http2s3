#!
source $(dirname $0)/config.sh

if [ -z "$($docker ps -f name=$docker_container -q)" ] ;then # if not runing container
  echo Container $docker_container not running!
else
  $docker stop $docker_container
fi
