#!/bin/bash
gcloud compute instances delete-access-config $1 --access-config-name "external-nat" --zone=europe-west1-b