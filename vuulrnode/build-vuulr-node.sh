#!/bin/bash

# Chris Drumgoole | chris.drumgoole@vuulr.com | Vuulr.com
#
# Builds a docker container for our custom image running geth

IMAGE_NAME="vuulrchain-node"

docker build -t $IMAGE_NAME -f Dockerfile .
