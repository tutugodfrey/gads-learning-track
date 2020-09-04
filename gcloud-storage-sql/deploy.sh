#! /bin/bash

# Configure firewall to allow http traffic
gcloud compute --project=$DEVSHELL_PROJECT_ID firewall-rules create default-allow-http \
--direction=INGRESS --priority=1000 --network=default --action=ALLOW \
--rules=tcp:80 --source-ranges=0.0.0.0/0 --target-tags=http-server

# Create a compute engine vm instance
gcloud compute instances create bloghost --zone=ZONE \
--machine-type "e2-medium" \
--image-project "debian-cloud" \
--image "debian-9-stretch-v20200902" \
--tags "http-server" \
--subnet "default" \
--metadata-from-file startup-script="./install.sh"

# gcloud compute instancces describe bloghost;

INSTANCE_IP = gcloud compute instances describe bloghost \
  --format='get(networkInterfaces[0].accessConfigs[0].natIP)'

# echo instance ip is ${INSTANCE_IP}


# Create a cloud storage bucket
export LOCATION=US
gsutil mb -l $LOCATION gs://$DEVSHELL_PROJECT_ID
gsutil cp gs://cloud-training/gcpfci/my-excellent-blog.png my-excellent-blog.png
gsutil cp !$ gs://$DEVSHELL_PROJECT_ID/!$
gsutil acl ch -u allUsers:R gs://$DEVSHELL_PROJECT_ID/my-excellent-blog.png;

# Create a cloud sql instance - correct
gcloud sql instances create DB_INSTANCE_ID \
--database-version=MYSQL_5_7 \
--root-password=ROOT_PASSWORD \
--region=us-central1

# Create a user for the sql instance
gcloud sql users create DB_USER \
--instance=DB_INSTANCE_ID \
--password=PASSWORD

# Connect to the database
# gcloud sql connect DB_INSTANCE_ID --user=DB_USER

# Create a cloud sql instance, mysql
#gcloud sql databases create MYSQL \
#--instance=blog-db \
#--sql-version=MYSQL_5_7 \
#--password=ROOT_PASSWORD \
#--region=REGION \
#--zone=ZONE
