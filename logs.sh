#!/bin/bash

# Chris Drumgoole | chris.drumgoole@vuulr.com | Vuulr.com
#
# Tail the container logs

NODE_NAME=$1
docker logs -f $NODE_NAME
