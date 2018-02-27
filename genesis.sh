#!/bin/bash

# Original Code from https://github.com/vertigobr/ethereum
# Modified for Vuulr needs - http://github.com/vuulr
#
# Chris Drumgoole | chris.drumgoole@vuulr.com | Vuulr.com
#
# Runs generates a unique genesis block for our purposes.
#
# GEN_NONCE: Vuulr private chain dev set to "0xaabaa78274dfdeas"
# GEN_CHAIN_ID: Vuulr private chain dev set to 47271
#* GEN_ALLOC: Pre-allocated balance to 100000000 for Vuulr

GEN_NONCE="0xaabaa78274dfdeas"
GEN_CHAIN_ID=47271
GEN_ALLOC='"0x0000000000000000000000000000000000000000": {"balance": "100000000"}'
sed "s/\${GEN_NONCE}/$GEN_NONCE/g" src/genesis.json.template | sed "s/\${GEN_ALLOC}/$GEN_ALLOC/g" | sed "s/\${GEN_CHAIN_ID}/$GEN_CHAIN_ID/g" > genesis.json
