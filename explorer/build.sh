#!/bin/bash

# Chris Drumgoole | chris.drumgoole@vuulr.com | Vuulr.com
#
# Builds a docker container for our netstats instance

IMAGE_NAME="vuulrchain-explorer"
docker build -t $IMAGE_NAME .
