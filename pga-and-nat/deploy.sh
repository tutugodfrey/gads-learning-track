#! /bin/bash

my_bucket=$DEVSHELL_PROJECT_ID
sed -i -e 's/BUCKET/'$my_bucket/ ./startup_script.sh

create_network_and_firewall () {
  gcloud compute networks create privatenet --subnet-mode custom
  gcloud compute networks subnets create privatenet-us --network privatenet --region us-central1 --range 10.130.0.0/20

  # Create firewall rules for the network
  # Note we
  gcloud compute firewall-rules create privatenet-allow-ssh --network privatenet --direction INGRESS --priority 1000 --action ALLOW --source-ranges 35.235.240.0/20 --rules tcp:22

  # Alternative Note the --target-tags
  # gcloud compute firewall-rules create privatenet-allow-ssh --network privatenet --direction INGRESS --priority 1000 --action ALLOW --source-ranges 35.235.240.0/20 --rules tcp:22 --target-tags backend
}

create_vm_internal () {
  # Create vm instance vm-internal 
  gcloud compute instances create vm-internal --no-address --zone us-central1-c --machine-type n1-standard-1 --network privatenet --subnet privatenet-us --metadata-from-file startup-script="./startup_script.sh"
  # --no-address will ensure the vm does not have an external IP address.
}

iap_tunnel () {
  gcloud compute ssh vm-internal --zone us-central1-c --tunnel-through-iap
}


create_bucket () {
  # Create cloud storage bucket and copy file from another cloud storage bucket to the cloud storage bucket just created for use later
  gsutil mb gs://$my_bucket
  gsutil cp gs://cloud-training/gcpnet/private/access.svg gs://$my_bucket
}

use_pga () {
  # This will work in cloud shell by default.
  # But for a vm, Private google access needs to be enabled which is what we do in enable_pga
  # After that this should work for the vm
  gsutil cp gs://$my_bucket/*.svg .
}

enable_pga () {
  # Update the privatenet-us subnet to enable Private Google Access
  gcloud compute networks subnets update privatenet-us --region us-central1 --enable-private-ip-google-access
}

update_package_index () {
  # This should work in cloud shell
  # But fails for vm without external IP address
  # We us cloud nat to enable vm access the external network for update and the like. 
  # But external traffic cannot get to the vm by default, only the vm can initiate a connection
  sudo apt-get update
}

create_cloud_nat () {
  #   --auto-allocate-nat-external-ips | --nat-external-ip-pool
  # --nat-all-subnet-ip-ranges | --nat-custom-subnet-ip-ranges | --nat-primary-subnet-ip-ranges
  gcloud compute routers create nat-router --network privatenet --region us-central1
  gcloud compute routers nats create nat-config --router nat-router --auto-allocate-nat-external-ips --nat-all-subnet-ip-ranges --region us-central1
}

enable_cloud_nat_logging () {
 # gcloud compute routers nats update NAME --router=ROUTER
  gcloud compute routers nats update nat-config --router nat-router --region us-central1 --enable-logging --log-filter ALL
}
