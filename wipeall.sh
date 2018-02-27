#!/bin/bash

# Original Code from https://github.com/vertigobr/ethereum
# Modified for Vuulr needs - http://github.com/vuulr
#
# Chris Drumgoole | chris.drumgoole@vuulr.com | Vuulr.com
#
# This script clears the environment so we can start anew.

DATA_ROOT=${DATA_ROOT:-$(pwd)}
echo "Removing containers..."
docker stop $(docker ps -q -f name=vuulrchain)
docker rm $(docker ps -aq -f name=vuulrchain)
echo "Removing network..."
docker network rm vuulr-ethereum-chain
echo "Removing volumes in $DATA_ROOT..."
rm -Rf $DATA_ROOT/.ether-*
rm -Rf $DATA_ROOT/.ethash
rm -Rf $DATA_ROOT/.bootnode
