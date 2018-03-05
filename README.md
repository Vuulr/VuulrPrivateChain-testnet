Vuulr's Private Ethereum Dev Chain (PoA) with Docker (Local Access)
==========

Original code forked from https://github.com/vertigobr/ethereum and modified for Vuulr needs. Special thanks to the team at vertigobar.

Generally, we leverage the existing public images in docker hub, however, we make our own modified version of the container to install and run eth-net-intelligence-api.

These instructions are focused on getting a PoA network up and running with a few sealers (poa miners) and a few nodes (with one enabled for localhost rpc access)

## Quick start for a PoA Private Chain

Install and run Docker on your computer:

* Build Vuulr's Ethereum geth node image
* Make accounts for the sealers (PoA Miners)
* Run a bootnode (this is required first to get the docker network up and running)
* Build and then run the netstats image/container node (need to do this before running the sealers or nodes as we need the IP for them)
* Generate genesis block json
* Run the sealer nodes
* Run the listening nodes

```sh
./vuulrnode/build.sh
./bootnode.sh
./netstats/build.sh
./netstats/run.sh
./genesis-poa.sh
./runsealer.sh
./runnode.sh
./runlocalnode.sh
./showpeers.sh
```

(Note, you can run a normal PoW network by running genesis.sh and runminer.sh as opposed to runsealer.sh. The rest of these instructions assume you want a PoA)

## Ethereum Network Definition

The 'genesis.sh' and 'genesis-poa.sh' scripts generate a 'genesis.json' used for running the network.

For PoA, 'genesis-poa.sh' will pre-fund the accounts we will use for the sealers. Therefore, it is important to create the accounts first using 'makeaccounts.sh'.

You can modify this script by changing the following values:

* GEN_CHAIN_ID: any integer value your nodes agree upon, the default is 47271

The 'runnode.sh' scripts checks if the node database has already been initialized and runs 'geth init genesis.json' when needed. Similarly, the GEN_CHAIN_ID variable defines the "network_id" of the network. All members of the private network will use the same genesis file.

## Bootnode

A bootnode is a "dumb" node in the network that aids other nodes on P2P discovery.

There are several valid strategies to enable node discovery (including a static topology with disabled discovery). Having one or more bootnodes seems to be the best one, for it creates no obstacles for a dynamic network.

As a dumb node, the bootnode is a cheap and effective solution to aid the network self-discovery. It fits container-land perfectly, because any swarm can ressurect such a node almost instantly. The main Ethereum network itself is served by a set of bootnodes whose addresses are hard-coded in the "geth" client code.

The `bootnode.sh` script runs a specialized bootnode container named "vuulrchain-bootnode". You can check its dynamically generated URL checking its log:

```sh
./logs.sh bootnode
...
INFO [12-05|02:30:08] UDP listener up      self=enode://c409a84245a91384a6743e800c4f45df31915d9c6a30c1352a4442d18e443b184107696231d714f3c3015f13263a416ec019d637fb567aea5455114f1cf161d2@[::]:30301
```

There is another useful script that parses the "enode" URL from this very same log (it is used in other scripts to find the bootnode URL automatically):

```sh
./getbootnodeurl.sh
enode://76e50d0dd4ae583d2653d414f9acd1df4e7a75f4bab53c7cafedc6433696ba9596c6dc84626423e629760b3ab2af9f97220dfee73961cb5be1a8ce1fa40a0bff@172.17.0.4:30301
```

## Volumes

The provided utility scripts are meant for local development use and rely on local volumes to persist data. For example, the script `runnode.sh <node_name>` creates a local volume ".ether-<node_name>" at the current folder. When using this container in production you should try another strategy to guarantee the node portability.

The folders created by each script are:

* bootnode.sh: volume ".bootnode"
* runnode.sh: volume ".ether-<node_name>" (ex: "./runnode node1" creates the volume ".ether-node1")
* runminer.sh and runsealer.sh: volume ".ether-<miner_name>" (id.)

Note: if ran without arguments the scripts `runnode.sh`, `runminer.sh` `runsealer.sh` assume the argument "node1" and "miner1", respectively.

## Your first node

The script `runnode.sh` runs the first node in your private Ethereum network (a container named "vuulrchain-node1"). It is important to notice that it looks for and connects to the bootnode, but since it is alone in the world it won't find any peer (yet) - the bootnode is a dumb node that doesn't count as a peer.

```sh
./runnode.sh
```

## Your second node

The same script `runnode.sh` can be used to run as many other nodes you want, all you need is to supply a node name as its argument. A container named "vuulrchain-<node_name>" will be created and started, looking for the bootnode and eventually finding the first node (and the others you ran) as its peer.

```sh
./runnode.sh node2
```

## A node accessible for RPC calls

The script `runlocalnode.sh` can be used to run a node but with RPC on port 8545 enabled. You can then use Metamask to connect to localhost:8545.

## Checking the nodes' peers

Self-discovery can take a few seconds, but it is easy to check it with the script `showpeers.sh`. The command below shows the peers of container "vuulrchain-node1":

```sh
./showpeers.sh
```

An optional argument can specify another node container to be checked:

```sh
./showpeers.sh node2
```

## Running a sealer (poa miner) node

The nodes "vuulrchain-node1" and "vuulrchain-node2" are non-mining or sealing nodes - they serve the purpose of testing the ability to create a private Ethereum network capable of self-discovery. Another script `runsealer.sh` is similar to the `runnode.sh`, but it starts poa sealer nodes (it assumes "miner1" if ran without arguments):

```sh
./runsealer.sh [node_name]
```

To check if it discovered its peers "node1" and "node2":

```sh
./showpeers.sh vuulrchain-miner1
```


```sh
./logs.sh miner1
```
