#!/bin/bash
docker run -d --rm -p 3001:3000 -e VAR=3 --name node1 my-node
docker run -d --rm -p 3002:3000 -e VAR=2 --name node2 my-node