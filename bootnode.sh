#!/bin/sh

# Original Code from https://github.com/vertigobr/ethereum
# Modified for Vuulr needs - http://github.com/vuulr
#
# Chris Drumgoole / chris.drumgoole@vuulr.com
#
# Runs a bootnode with ethereum official "alltools" image.
#
CONTAINER_NAME="vuulrchain-bootnode"
NETWORK="vuulr-ethereum-chain"

# Stop and remove the old container if it exists
docker stop $CONTAINER_NAME
docker rm $CONTAINER_NAME

IMGNAME="ethereum/client-go:alltools-v1.7.3"

DATA_ROOT=${DATA_ROOT:-$(pwd)}
# generate bootnode key if needed
mkdir -p $DATA_ROOT/.bootnode
if [ ! -f $DATA_ROOT/.bootnode/boot.key ]; then
    echo "$DATA_ROOT/.bootnode/boot.key not found, generating..."
    docker run --rm \
        -v $DATA_ROOT/.bootnode:/opt/bootnode \
        $IMGNAME bootnode --genkey /opt/bootnode/boot.key
    echo "...done!"
fi
# creates ethereum network
[ ! "$(docker network ls | grep vuulr-ethereum-chain)" ] && docker network create $NETWORK
[[ -z $BOOTNODE_SERVICE ]] && BOOTNODE_SERVICE="127.0.0.1"
docker run -d --name $CONTAINER_NAME \
    -v $DATA_ROOT/.bootnode:/opt/bootnode \
    --network $NETWORK \
    $IMGNAME bootnode --nodekey /opt/bootnode/boot.key --verbosity=3 "$@"
# --addr "$BOOTNODE_SERVICE:30301" "$@"
