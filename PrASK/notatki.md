```
docker run --name vm1 --network="my-net" --ip="10.0.0.1" --ip6="2a0b:5485:0:13::a"  -dv /home/281822/srv/vm1:/usr/share/nginx/html:ro nginx:alpine

docker network create --subnet 10.0.0.0/24 --gateway 10.0.0.254 --ipv6 --subnet=2a0b:5485:0:13::1:0/112 --driver bridge my-net
docker run --name vm1 --network="my-net" --ip="10.0.0.1" --ip6="2a0b:5485:0:13::1:a" -dv /home/281822/srv/vm1:/usr/share/nginx/html:ro nginx:alpine
docker run --name vm2 --network="my-net" --ip="10.0.0.2" --ip6="2a0b:5485:0:13::1:b" -dv /home/281822/srv/vm2:/usr/share/nginx/html:ro nginx:alpine

docker run --name vm1 --network="my-net" --ip="10.0.0.1" --ip="10.0.0.12" --ip6="2a0b:5485:0:13::1:a" -dv /home/281822/srv/vm1:/usr/share/nginx/html:ro nginx:alpine
docker run --name vm2 --network="my-net" --ip="10.0.0.2" --ip="10.0.0.12" --ip6="2a0b:5485:0:13::1:b" -dv /home/281822/srv/vm2:/usr/share/nginx/html:ro nginx:alpine

docker run --name vm3 --network="my-net" --ip="10.0.0.12" -dv /home/281822/srv/vm3:/usr/share/nginx/html:ro mydocker
```
