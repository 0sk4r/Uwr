#!/bin/bash

./create-instance-from-image.sh server1 10.132.0.2 webserver
./create-instance-from-image.sh server2 10.132.0.3 webserver
./create-instance-from-image.sh server3 10.132.0.4 webserver
./create-instance-from-image.sh loadbalancer 10.132.0.10 loadbalancer