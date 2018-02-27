#!/bin/sh

# Original Code from https://github.com/vertigobr/ethereum
# Modified for Vuulr needs - http://github.com/vuulr
#
# Chris Drumgoole | chris.drumgoole@vuulr.com | Vuulr.com
#
# Queries a node's peers
#
NODE=$1
NODE=${NODE:-"node1"}
CONTAINER_NAME="vuulrchain-$NODE"
docker exec -ti "$CONTAINER_NAME" geth --exec 'admin.peers' attach
