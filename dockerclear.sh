#!/bin/bash

# Chris Drumgoole | chris.drumgoole@vuulr.com | Vuulr.com
# (c) 2018 Vuulr Pte Ltd
#
# Clear Docker's images and containers

echo "Removing containers"
docker rm $(docker ps -a -q)

echo "Removing images"
docker rmi -f $(docker images -q)
