#!/bin/bash

gcloud compute instances create $1 --machine-type=f1-micro --image-project=coral-shoreline-234300 --image=$3 --tags=http-server --zone=europe-west1-b --private-network-ip=$2