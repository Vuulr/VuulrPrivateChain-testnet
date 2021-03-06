#!/bin/bash

# Original Code from https://github.com/vertigobr/ethereum
# Modified for Vuulr needs - http://github.com/vuulr
#
# Chris Drumgoole | chris.drumgoole@vuulr.com | Vuulr.com
#
# Runs a new node with name in command line parameter

CHAIN_ID=47271

IMGNAME="vuulrchain-node"
NODE_NAME=$1
NODE_NAME=${NODE_NAME:-"node1"}

NETSTATS_IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' vuulrchain-netstats)
WS_SERVER=${WS_SERVER:-"http:\/\/$NETSTATS_IP:3000"}

DETACH_FLAG=${DETACH_FLAG:-"-d"}
CONTAINER_NAME="vuulrchain-$NODE_NAME"
NETWORK="vuulr-ethereum-chain"

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

echo "Checking for keystore"
if [ ! -d $DATA_ROOT/keystore ]; then
    echo "$DATA_ROOT/keystore not found, running 'geth init'..."
    docker run --rm \
        -v $DATA_ROOT:/root/.ethereum \
        -v $(pwd)/genesis.json:/opt/genesis.json \
        $IMGNAME init /opt/genesis.json
    echo "...done!"
fi

echo "Running new container $CONTAINER_NAME with image $IMGNAME..."
docker run $DETACH_FLAG --name $CONTAINER_NAME \
    --network $NETWORK \
    -v $DATA_ROOT:/root/.ethereum \
    -v $DATA_HASH:/root/.ethash \
    -v $(pwd)/genesis.json:/opt/genesis.json \
    $MOUNT \
    $RPC_PORTMAP \
    $IMGNAME --rpc --bootnodes=$BOOTNODE_URL $RPC_ARG --cache=512 --verbosity=4 --maxpeers=3 --gasprice 1 --networkid=$CHAIN_ID ${@:2}
echo $RPC_ARG

docker exec -w /root -ti $CONTAINER_NAME /bin/sh -c "sed -i 's/\${WS_SERVER}/$WS_SERVER/g' /root/netstats.json"
docker exec -w /root -ti $CONTAINER_NAME /bin/sh -c "sed -i 's/\${NODE_NAME}/$NODE_NAME/g' /root/netstats.json"
docker exec -w /root -ti $CONTAINER_NAME /bin/sh -c "/usr/bin/pm2 start /root/netstats.json"
