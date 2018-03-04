docker rmi $(docker images --filter "dangling=true" -q --no-trunc)
docker rmi $(docker images | grep "none" | awk '/ / { print $3 }')
docker rm $(docker ps -qa --no-trunc --filter "status=exited")
docker network ls | awk '$3 == "bridge" && $2 != "bridge" { print $1 }'
