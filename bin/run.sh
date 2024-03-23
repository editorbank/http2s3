#!
source $(dirname $0)/config.sh

if [ -z "$($docker images -f reference=$docker_image -q)" ] ;then # if not exist image
  $(dirname $0)/build.sh
fi

if [ ! -z "$($docker images -f reference=$docker_image -q)" ] ;then # if exist image
  if [ -z "$($docker ps -a -f name=$docker_container -q)" ] ;then # if not exist container
    echo Create $docker_container ...
    $docker create -P --name $docker_container $docker_image
  fi
  if [ -z "$($docker ps -f name=$docker_container -q)" ] ;then # if not runing container
    echo Start $docker_container ...
    $docker start $docker_container
  else
    echo Container $docker_container already running.
  fi
else
  echo Image $docker_image not created!
fi
container_port=$($docker port $docker_container|cut -d: -f2)
echo  Container URL: http://localhost:$container_port
[ -n "$(whereis curl | awk '{print $2}')" ] && curl -D- http://localhost:$container_port
[ -n "$(whereis browse | awk '{print $2}')" ] && browse http://localhost:$container_port