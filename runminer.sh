#!/bin/bash

# Original Code from https://github.com/vertigobr/ethereum
# Modified for Vuulr needs - http://github.com/vuulr
#
# Chris Drumgoole | chris.drumgoole@vuulr.com | Vuulr.com
#
# Runs a new mining node

NODE_NAME=$1
NODE_NAME=${NODE_NAME:-"miner1"}

NETSTATS_IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' vuulrchain-netstats)
WS_SERVER=${WS_SERVER:-"http:\/\/$NETSTATS_IP:3000"}

#export WS_SERVER

#ETHERBASE=${ETHERBASE:-"0x0000000000000000000000000000000000000001"}
ETHERBASE=${ETHERBASE:-"0x4fA61b525CBAFdb29619697B68b46436256E5408"}

./runnode.sh $NODE_NAME --mine --minerthreads=1 --etherbase="$ETHERBASE"
