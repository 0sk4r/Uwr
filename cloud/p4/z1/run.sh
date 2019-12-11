#!/bin/bash
# docker run --rm --name nginx-container$i -v ~/Uwr/cloud/p4/z1/site:/usr/share/nginx/html:ro -p 8080:80 -d nginx:alpine
docker build -t my-haproxy-image ./haproxy/
docker network create network1
for i in 1 2 3
do
    docker run --rm --net network1 --name nginx-container$i -v ~/Uwr/cloud/p4/z1/site:/usr/share/nginx/html:ro -d nginx:alpine
done

# docker run -d  --rm --net network1 --name haproxy-container -v ~/Uwr/cloud/p4/z1/haproxy:/usr/local/etc/haproxy:ro haproxy:alpine -p 8080:80

docker run -d --rm --net network1 --name haproxy-container -p 8080:80 my-haproxy-image