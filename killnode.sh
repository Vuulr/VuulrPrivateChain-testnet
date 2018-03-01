#!/bin/bash

# Original Code from https://github.com/vertigobr/ethereum
# Modified for Vuulr needs - http://github.com/vuulr
#
# Chris Drumgoole | chris.drumgoole@vuulr.com | Vuulr.com
#
# kills a named container
#

NODE_NAME=$1
NODE_NAME=${NODE_NAME:-"node1"}
CONTAINER_NAME="vuulrchain-$NODE_NAME"

echo "Destroying container $CONTAINER_NAME..."
docker stop $CONTAINER_NAME
docker rm $CONTAINER_NAME
