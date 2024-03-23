this_file="$(realpath $0)"
bin_dir="$(dirname $this_file)"
export project_root="$(realpath $bin_dir/..)"
export project_config="$project_root/project.properties"

if [ ! -f "$project_config" ];then echo "Error, not found config \"$project_config\"!"; exit 1;fi

while IFS='=' read -d $'\n' -r k v; do
  [[ "$k" =~ ^([[:space:]]*|[[:space:]]*#.*)$ ]] && continue
  eval export $k="$v"
done < $project_config

export docker_image=$project_maintainer/$project_name:$project_version
export docker_container=${project_maintainer}_$project_name
