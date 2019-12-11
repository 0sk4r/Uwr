#!/bin/bash

for i in 1 2 3
do
    docker stop nginx-container$i
done

docker stop haproxy-container

docker network rm network1
