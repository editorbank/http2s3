set -xe
docker=${1:-docker}
network_name=http2s3_network
${docker} network inspect ${network_name} >/dev/null || ${docker} network create ${network_name}

if [ "$docker" == "podman" ] ; then
  new_ver=$( podman network inspect ${network_name} | grep -E '\"cniVersion\"\: \"[0-9]\.[0-9]\.[0-9]\"' -o )
  sys_ver=$( podman network inspect podman | grep -E '\"cniVersion\"\: \"[0-9]\.[0-9]\.[0-9]\"' -o )
  echo new_ver=$new_ver
  echo sys_ver=$sys_ver
  [ "$new_ver" != "$sys_ver" ] && sed -i "s/$new_ver/$sys_ver/" ~/.config/cni/net.d/${network_name}.conflist
fi

${docker} ps -q -f "name=$(basename $PWD)_" | xargs -r ${docker} rm -f
${docker}-compose up --build --force-recreate
echo DONE