#!/bin/bash

gcloud compute instances create $1 --machine-type=f1-micro --image-project=debian-cloud --image-family=debian-9 --tags=http-server --zone=europe-west1-b --private-network-ip=$2
