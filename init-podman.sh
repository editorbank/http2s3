new_file=$(podman network exists http2s3_default || podman network create http2s3_default)
new_ver=$( podman network inspect http2s3_default | grep -E '\"cniVersion\"\: \"[0-9]\.[0-9]\.[0-9]\"' -o )
sys_ver=$( podman network inspect podman | grep -E '\"cniVersion\"\: \"[0-9]\.[0-9]\.[0-9]\"' -o )
echo new_ver=$new_ver
echo sys_ver=$sys_ver
[ "$new_ver" != "$sys_ver" ] && sed -i "s/$new_ver/$sys_ver/" ~/.config/cni/net.d/http2s3_default.conflist

podman-compose down
podman rmi -f docker.io/editorbank/http2s3
podman-compose up
