#!/bin/bash

# Chris Drumgoole | chris.drumgoole@vuulr.com | Vuulr.com
#
# Runs the netstats container instance

NETWORK="vuulr-ethereum-chain"
CONTAINER_NAME="vuulrchain-explorer"
IMAGE_NAME=$CONTAINER_NAME

docker stop $CONTAINER_NAME
docker rm $CONTAINER_NAME
docker run -d -p 8000:8000 --network=$NETWORK --name=$CONTAINER_NAME $IMAGE_NAME
echo "IP Adddress: "
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' vuulrchain-explorer
