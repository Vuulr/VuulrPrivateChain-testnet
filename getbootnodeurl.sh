#!/bin/bash

# Original Code from https://github.com/vertigobr/ethereum
# Modified for Vuulr needs - http://github.com/vuulr
#
# Chris Drumgoole | chris.drumgoole@vuulr.com | Vuulr.com
#
# Gets the bootnode enode address
#

CONTAINER_NAME="vuulrchain-bootnode"

# reads current bootnode URL
ENODE_LINE=$(docker logs $CONTAINER_NAME 2>&1 | grep enode | head -n 1)
# replaces localhost by container IP
MYIP=$(docker exec $CONTAINER_NAME ifconfig eth0 | awk '/inet addr/{print substr($2,6)}')
ENODE_LINE=$(echo $ENODE_LINE | sed "s/127\.0\.0\.1/$MYIP/g" | sed "s/\[\:\:\]/$MYIP/g")
echo "enode:${ENODE_LINE#*enode:}"
