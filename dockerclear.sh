#!/bin/bash

# Chris Drumgoole | chris.drumgoole@vuulr.com | Vuulr.com
#
# Clear Docker's images and containers

echo "Removing containers"
docker rm $(docker ps -a -q)

echo "Removing images"
docker rmi -f $(docker images -q)
