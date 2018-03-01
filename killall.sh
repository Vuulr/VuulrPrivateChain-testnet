#!/bin/bash

# Original Code from https://github.com/vertigobr/ethereum
# Modified for Vuulr needs - http://github.com/vuulr
#
# Chris Drumgoole | chris.drumgoole@vuulr.com | Vuulr.com
#
# Kills all containers and removes them 
#
docker stop $(docker ps -q -f name=vuulrchain)
docker rm $(docker ps -aq -f name=vuulrchain)
