#!/bin/bash

# Original Code from https://github.com/vertigobr/ethereum
# Modified for Vuulr needs - http://github.com/vuulr
#
# Chris Drumgoole | chris.drumgoole@vuulr.com | Vuulr.com
#
# Runs a new (locally accessible) node with rpc port opened for docker

NODE_NAME=$1
NODE_NAME=${NODE_NAME:-"node1"}

# Set RPC Port which will trigger the RPC settings in runnode.sh so we can access this node locally
RPC_PORT="8545"

#export WS_SERVER
export RPC_PORT

./runnode.sh $NODE_NAME
