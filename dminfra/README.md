# Automating the Deployment of Infrastructure Using Deployment Manager

This project demonstrates how to deploy infrastructure to Google Cloud using the deployment manager. This follows the qwiklabs project [Automating the Deployment of Infrastructure Using Deployment Manager](https://googlepluralsight.qwiklabs.com/focuses/10917092?parent=lti_session)

 
## Steps to create the deployment

- Clone the repository

'git clone https:github.com/tutugodfrey/gads-learning-track`

- Change working directory

`cd gads-learning-track/dminfra`

- Preview the deployment

`gcloud deployment-manager deployments create dminfra --config=config.yaml --preview`

- Create/update deployemnt

`gcloud deployment-manager deployments update dminfra`

- Delete the deployment

`gcloud deployment-manager deployments delete dminfra`


