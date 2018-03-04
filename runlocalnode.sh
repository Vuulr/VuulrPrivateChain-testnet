#!/bin/bash

# Original Code from https://github.com/vertigobr/ethereum
# Modified for Vuulr needs - http://github.com/vuulr
#
# Chris Drumgoole | chris.drumgoole@vuulr.com | Vuulr.com
#
# Runs a new mining node

NODE_NAME=$1
NODE_NAME=${NODE_NAME:-"node1"}

NETSTATS_IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' vuulrchain-netstats)
WS_SERVER=${WS_SERVER:-"http:\/\/$NETSTATS_IP:3000"}

RPC_PORT="8545"

#export WS_SERVER
export RPC_PORT

./runnode.sh $NODE_NAME
