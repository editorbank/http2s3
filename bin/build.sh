#!
source $(dirname $0)/config.sh

if [ ! -z "$($docker images --filter=reference=$docker_image -q)" ] ;then
  echo Image $docker_image already builded!
else
  $docker build -t $docker_image $project_root
fi


