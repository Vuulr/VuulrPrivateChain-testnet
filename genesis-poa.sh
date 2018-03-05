#!/bin/bash

# Chris Drumgoole | chris.drumgoole@vuulr.com | Vuulr.com
# (c) 2018 Vuulr Pte Ltd
#
# Create genisis.json for our POA network

NODE_COUNT=$1
NODE_COUNT=${NODE_COUNT:-"2"}

NODE_PREFIX=$2
NODE_PREFIX=${NODE_PREFIX:-"miner"}

GEN_ALLOC=""

GEN_CHAIN_ID=47271

for i in `seq 1 $NODE_COUNT`;
  do
    NODE_NAME=$NODE_PREFIX$i
    echo "Getting address for account $i..."
    ADDRESS=`docker run --rm -it --mount source=accounts,target=/tmp/accounts alpine:edge /bin/sh -c 'for file in /tmp/accounts/'$NODE_NAME'/keystore/*; do printf $file; done;'`
    ADDRESS=${ADDRESS: -40}
    echo "Address found is:" $ADDRESS
    GEN_ALLOC="$GEN_ALLOC \"$ADDRESS\":{\"balance\":\"30000000000000000000\"},"
done

# Do the job!
sed "s/\${GEN_CHAIN_ID}/$GEN_CHAIN_ID/g" src/genesis-poa.json.template | sed "s/\${GEN_ALLOC}/$GEN_ALLOC/g" > genesis.json
