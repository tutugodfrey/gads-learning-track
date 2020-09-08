#! /bin/bash

gsutil cp gs://cloud-training/gcpfcoreinfra/mydeploy.yaml mydeploy.yaml
sed -i -e "s/PROJECT_ID/$DEVSHELL_PROJECT_ID/" mydeploy.yaml
sed -i -e "s/ZONE/$MY_ZONE/" mydeploy.yaml
gcloud deployment-manager deployments create my-first-depl --config mydeploy.yaml


# Update the deployment; install nginx server
sed -i -e 's/"apt-get update"/'"apt-get update; apt-get install nginx-light -y"/ mydeploy.yaml
gcloud deployment-manager deployments update my-first-depl --config mydeploy.yaml