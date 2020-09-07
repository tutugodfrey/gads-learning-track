# Google Cloud Fundamentals: Getting Started with Deployment Manager and Cloud Monitoring
 

This project demonstrate how to deploy an nginx server on google compute engine using the deployment manager following the instructions from the qwiklabs project [Google Cloud Fundamentals: Getting Started with Deployment Manager and Cloud Monitoring](https://googlepluralsight.qwiklabs.com/focuses/10897727?parent=lti_session). The aim of this project is to convert the instructions to a scripted version to simplify the deploment process.

## Step to create the deployment

- Clone this repository

`git clone https://github.com/tutugodfrey/gads-learning-track`

- Change working directory

`cd gads-learning-track/deployment-manager-gs`

- Set compute zone to environment variable

complete the export below with your preferred zone or zone assigned by qwiklabs if you are using qwiklabs

`export MY_ZONE=`

- Create the deployment

`./deploy.sh`

The deploy script will download mydeploy.yaml from cloud storage bucket associated with the project and update the variable and create the deployment

- Update the deployment

`./update-deployment.sh`

The update deployment script will update the metadata of the compute instance to include step to install an nginx server and update the deployment.

Follow instructions in the links below for installing monitoring agents

[Monitoring](https://cloud.google.com/monitoring/agent/installation?_ga=2.84126236.-442174862.1599479303#agent-install-debian-ubuntu)

[Logging](https://cloud.google.com/logging/docs/agent/installation/?_ga=2.119243276.-442174862.1599479303)
