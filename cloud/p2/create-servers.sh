#!/bin/bash

./create-instance.sh server1 10.132.0.2
./create-instance.sh server2 10.132.0.3
./create-instance.sh server3 10.132.0.4
./create-instance.sh loadbalancer 10.132.0.10
./create-instance.sh cms 10.132.0.5