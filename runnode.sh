#!/bin/bash

# Original Code from https://github.com/vertigobr/ethereum
# Modified for Vuulr needs - http://github.com/vuulr
#
# Chris Drumgoole | chris.drumgoole@vuulr.com | Vuulr.com
#
# Runs a new node with name in command line parameter

IMGNAME="ethereum/client-go:v1.7.3"
NODE_NAME=$1
NODE_NAME=${NODE_NAME:-"node1"}
DETACH_FLAG=${DETACH_FLAG:-"-d"}
CONTAINER_NAME="vuulrchain-$NODE_NAME"
NETWORK="vuulr-ethereum-chain"
#RPC_PORT=8545

DATA_ROOT=${DATA_ROOT:-"$(pwd)/.ether-$NODE_NAME"}
DATA_HASH=${DATA_HASH:-"$(pwd)/.ethash"}

echo "Destroying old container $CONTAINER_NAME..."
docker stop $CONTAINER_NAME
docker rm $CONTAINER_NAME

echo "Setting of variables for docker container"
RPC_PORTMAP=
RPC_ARG=
if [[ ! -z $RPC_PORT ]]; then
    RPC_ARG='--rpc --rpcaddr=0.0.0.0 --rpcapi=db,eth,net,web3,personal --rpccorsdomain "*"'
    RPC_PORTMAP="-p $RPC_PORT:8545"
fi

echo "Getting bootnode information"
BOOTNODE_URL=${BOOTNODE_URL:-$(./getbootnodeurl.sh)}

echo "Checking for genesis.json"
if [ ! -f $(pwd)/genesis.json ]; then
    echo "No genesis.json file found, please run 'genesis.sh'. Aborting."
    exit
fi

echo "Chrcing for keystore"
if [ ! -d $DATA_ROOT/keystore ]; then
    echo "$DATA_ROOT/keystore not found, running 'geth init'..."
    docker run --rm \
        -v $DATA_ROOT:/root/.ethereum \
        -v $(pwd)/genesis.json:/opt/genesis.json \
        $IMGNAME init /opt/genesis.json
    echo "...done!"
fi

echo "Running new container $CONTAINER_NAME..."
docker run $DETACH_FLAG --name $CONTAINER_NAME \
    --network $NETWORK \
    -v $DATA_ROOT:/root/.ethereum \
    -v $DATA_HASH:/root/.ethash \
    -v $(pwd)/genesis.json:/opt/genesis.json \
    $RPC_PORTMAP \
    $IMGNAME --bootnodes=$BOOTNODE_URL $RPC_ARG --cache=512 --verbosity=4 --maxpeers=3 ${@:2}
