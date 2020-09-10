#! /bin/bash

project=$DEVSHELL_PROJECT_ID
sed -i -e 's/BUCKETNAME/'$project/ ./startup_script.sh
vm_name=mc-server

create_vm () {
  gcloud compute addresses create mc-server-ip --project=$project --region=us-central1 # create a static ip address (reserved)
  ipaddress=$(gcloud compute addresses describe mc-server-ip --region us-central1 | grep address: | sed 's/address: /'""/) # get the value of the ip address
  echo reserved ip address is $ipaddress
  gcloud beta compute  instances create $vm_name \
  --zone=us-central1-a \
  --machine-type=n1-standard-1 \
  --subnet=default \
  --address=$ipaddress \
  --tags=minecraft-server \
  --image=debian-10-buster-v20200902 \
  --image-project=debian-cloud \
  --boot-disk-size=10GB \
  --boot-disk-type=pd-standard \
  --boot-disk-device-name=$vm_name \
  --metadata-from-file startup-script=./startup_script.sh \
  --create-disk=mode=rw,size=50,type=projects/todo-er/zones/us-central1-a/diskTypes/pd-ssd,name=minecraft-disk,device-name=minecraft-disk \
  --no-shielded-secure-boot \
  --no-shielded-vtpm \
  --no-shielded-integrity-monitoring \
  --reservation-affinity=any

  # if you want to attech the ip address to already created vm
  # gcloud compute instances add-access-config todoapp-vm --project=todo-er --zone=us-central1-a --address=IP_OF_THE_NEWLY_CREATED_STATIC_ADDRESS
}

create_firewall_rule () {
  gcloud compute firewall-rules create minecraft-rule --direction INGRESS --priority 1000 --network default --action ALLOW --rules=tcp:25565 --source-ranges=0.0.0.0/0 --target-tags=minecraft-server
}

stop_vm () {
  gcloud compute instances stop mc-server
}
