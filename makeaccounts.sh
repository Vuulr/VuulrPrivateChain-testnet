#!/bin/bash

# Modified for Vuulr needs - http://github.com/vuulr
#
# Chris Drumgoole | chris.drumgoole@vuulr.com | Vuulr.com
#
# Makes x number of accounts used for creating sealers

CONTAINER_NAME="vuulrchain-account-factory"
DEFAULT_PW="vuulr1234!"

NODE_COUNT=$1
NODE_COUNT=${NODE_COUNT:-"2"}

NODE_PREFIX=$2
NODE_PREFIX=${NODE_PREFIX:-"miner"}

# Clean Up
docker stop $CONTAINER_NAME
docker rm $CONTAINER_NAME
docker volume rm accounts
docker volume create accounts

# Run the container
docker run -itd --name $CONTAINER_NAME \
    --mount source=accounts,target=/tmp/accounts \
    --entrypoint "/bin/sh" \
     ethereum/client-go:alltools-stable

# Create the pw file - simple pw for all
docker exec -w /tmp/accounts -ti $CONTAINER_NAME /bin/sh -c "echo $DEFAULT_PW > /tmp/accounts/password.txt"

# Loop to create accounts
for i in `seq 1 $NODE_COUNT`;
  do
    echo "Making account $i..."
    docker exec -w /tmp/accounts -ti $CONTAINER_NAME /bin/sh -c "mkdir $NODE_PREFIX$i"
    docker exec -w /tmp/accounts -ti $CONTAINER_NAME /bin/sh -c "geth --datadir $NODE_PREFIX$i/ account new docker exec -w /tmp/accounts -ti $CONTAINER_NAME /bin/sh -c "echo $DEFAULT_PW > /tmp/accounts/password.txt"

done

# Stop the container since we won't need it anymore
#docker stop $CONTAINER_NAME
