#!/bin/bash

# Vuulr - http://github.com/vuulr
#
# Chris Drumgoole | chris.drumgoole@vuulr.com | Vuulr.com
#
# Runs a new sealer node for PoA

NODE_NAME=$1
NODE_NAME=${NODE_NAME:-"miner1"}

NETSTATS_IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' vuulrchain-netstats)
WS_SERVER=${WS_SERVER:-"http:\/\/$NETSTATS_IP:3000"}

# Get the address from the miner account created by the factory
ADDRESS=`docker run --rm -it --mount source=accounts,target=/tmp/accounts alpine:edge /bin/sh -c 'for file in /tmp/accounts/'$NODE_NAME'/keystore/*; do printf $file; done;'`
ADDRESS=${ADDRESS: -40}
ETHERBASE=${ETHERBASE:-"0x$ADDRESS"}

echo "Found account address $ETHERBASE"

MOUNT="--mount source=accounts,target=/root/accounts"
export MOUNT

# Run node, specifcying location of the keystore for the respective sealer node
./runnode.sh $NODE_NAME --mine --unlock="$ETHERBASE" --keystore=/root/accounts/$NODE_NAME/keystore --password /root/accounts/password.txt
