#! /bin/bash

# Create Firewall rule
gcloud compute --project=$DEVSHELL_PROJECT_ID firewall-rules create default-allow-http \
--direction=INGRESS --priority=1000 --network=default --action=ALLOW \
--rules=tcp:80 --source-ranges=0.0.0.0/0 --target-tags=http-server

# Create Vm 1
gcloud compute instances create my-vm-1 \
--zone us-central1-a \
--machine-type "n1-standard-1" \
--image-project "debian-cloud" \
--image "debian-9-stretch-v20190213" \
--tags "http-server" \
--metadata-from-file startup-script="./install-nginx.sh" \
--subnet "default" 

# Create vm 2 
gcloud compute instances create my-vm-2 \
--zone us-central1-b \
--machine-type "n1-standard-1" \
--image-project "debian-cloud" \
--image "debian-9-stretch-v20190213" \
--tags "http-server" \
--metadata-from-file startup-script="./install-nginx.sh" \
--subnet "default"
