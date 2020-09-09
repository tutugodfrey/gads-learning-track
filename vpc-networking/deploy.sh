#! /bin/bash

delete_default_network () {
  # delete the default firewall rule
  gcloud compute firewall-rules delete default
  echo "Default firewall rules deleted"

  # Delete the default network
  gcloud compute networks delete default
  echo "default network deleted"
}

attempt_vm_creation () {
  echo "attempitng vm creation"
  gcloud compute instances create

  echo $?
}

create_mynetwork () {
  # Create a VPC network
  gcloud compute networks create mynetwork --subnet-mode=auto --bgp-routing-mode=regional

  gcloud compute firewall-rules create allow-icmp --network=mynetwork --direction=INGRESS --source-ranges=0.0.0.0/0 --action=ALLOW ---rules=icmp

  gcloud compute firewall-rules create allow-internal --network=mynetwork --direction=INGRESS --source-ranges=10.128.0.0/9 --action=ALLOW --rules=allow

  gcloud compute firewall-rules create allow-rdp --network=mynetwork --direction=INGRESS --source-ranges=0.0.0.0/0 --action=ALLOW --rules=tcp:3389

  gcloud compute firewall-rules create allow-ssh --network=mynetwork --direction=INGRESS --source-ranges=0.0.0.0/0 --action=ALLOW --rules=tcp:22

  # Create a vm in us-central1
  echo "Creating mynet-us-vm"
  gcloud compute instances create mynet-us-vm --zone us-central1-c --machine-type=n1-standard-1

  # Create a vm instance in europe-west1
  echo "Creating mynet-eu-vm"
  gcloud compute instances create mynet-eu-vm --zone europe-west1-c --machine-type n1-standard-1
}

convert_mynetwork_to_custom () {
  # Update the network to custom network
  gcloud compute networks update mynetwork --subnet-mode=custom
}

create_managenmentnet () {
  # Create a custom network
  # Managementnet
  echo "Creating managementnet"
  gcloud compute networks create mamagementnet --subnet-mode custom

  echo "Creating managementsubnet-us"
  gcloud compute networks subnets create managementsubnet-us --network managementnet --region us-central1 --ranges 10.130.0.0/20
}

create_privatenet () {
  # Privatenet
  echo "Creating privatenet"
  gcloud compute networks create privatenet --subnet-mode=custom
  echo "Creating privatesubnet-us"
  gcloud compute networks subnets create privatesubnet-us --network=privatenet --region=us-central1 --ranges=172.16.0.0/24
  echo "Creating privatesubnet-eu"
  gcloud compute networks subnets create privatesubnet-eu --network=privatenet --region=europe-west1 --range=172.20.0.0/20

  gcloud compute networks list
  gcloud compute networks subnets list --sort-by=NETWORK
}

create_firewall_rules () {
  # Create a firewall rule for managementnet
  echo "Creating firewall rules for managementnet"
  gcloud compute firewall-rules create managementnet-allow-icmp-ssh-rdp --network managementnet --direction INGRESS --action ALLOW --rules icmp,tcp:22,tcp:3389 --source-ranges 0.0.0.0/0

  # Create a firewall rule for privatenet
  echo "Creating firewall rules for privatenet"
  gcloud compute firewall-rules create privatenet-allow-icmp-ssh-rdp --direction INGRESS --priority 1000 --network privatenet --action ALLOW --rules icmp,tcp:22,tcp:3389 --source-ranges 0.0.0.0/0

  gcloud compute firewall-rules list --sort-by network
}

create_network_compute_instances () {
  # Create a vm instance in the managementsubnet-us subnet
  echo "Creating managementnet-us-vm"
  gcloud compute instances create managementnet-us-vm  --zone us-central1-c --machine-type f1-micro --network managementnet --subnet managementsubnet-us

  # Create a vm instance in the privatenetsubnet-us
  echo "Creating privatenet-us-vm"
  gcloud compute instances create privatenet-us-vm --zone us-central1-c --machine-type f1-micro --network privatenet --subnet privatesubnet-us

  gcloud compute instances list --sort-by=ZONE
}
