#!
source $(dirname $0)/config.sh

if [ ! -z "$($docker ps -a -f name=$docker_container -q)" ] ;then
  $docker container stop $docker_container || $docker container kill $docker_container
  $docker rm -f $docker_container
fi

if [ ! -z "$($docker images -f reference=$docker_image -q)" ] ;then
  $docker rmi -f $docker_image
fi
