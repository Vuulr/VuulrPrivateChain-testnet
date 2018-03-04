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

ETHERBASE=${ETHERBASE:-"0xc6af8ae732d1b0e08acfe97c26bcdc16904a5fbf"}
#ETHERBASE=${ETHERBASE:-"0x4a83da5397e1afe91d1aae7efc242bc37f4e9959"}



#ETHERBASE=${ETHERBASE:-"0x0000000000000000000000000000000000000001"}
MOUNT="--mount source=accounts,target=/root/accounts"
export MOUNT

#./runnode.sh $NODE_NAME --mine --unlock="$ETHERBASE" --datadir=/root/accounts/$NODE_NAME --password /root/accounts/password.txt
./runnode.sh $NODE_NAME --mine --unlock="$ETHERBASE" --keystore=/root/accounts/$NODE_NAME/keystore --password /root/accounts/password.txt
