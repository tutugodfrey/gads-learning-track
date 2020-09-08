#! /bin/bash

sed -i -e 's/"apt-get update"/'"apt-get update; apt-get install nginx-light -y"/ mydeploy.yaml
gcloud deployment-manager deployments update my-first-depl --config mydeploy.yaml
