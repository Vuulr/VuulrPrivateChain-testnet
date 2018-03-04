#!/bin/bash

# Chris Drumgoole | chris.drumgoole@vuulr.com | Vuulr.com
# (c) 2018 Vuulr Pte Ltd
#
# Create genisis.json for our POA network


GEN_NONCE="0xaabaa78274dfdeaa"
GEN_CHAIN_ID=47271


# Replace strings
#sed "s/\${GEN_NONCE}/$GEN_NONCE/g" src/genesis-poa.json.template | sed "s/\${GEN_ALLOC}/$GEN_ALLOC/g" | sed "s/\${GEN_CHAIN_ID}/$GEN_CHAIN_ID/g" > genesis.json
sed "s/\${GEN_NONCE}/$GEN_NONCE/g" src/genesis-poa.json.template | sed "s/\${GEN_CHAIN_ID}/$GEN_CHAIN_ID/g" > genesis.json
