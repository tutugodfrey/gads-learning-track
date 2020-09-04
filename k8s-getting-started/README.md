# Google Cloud Fundamentals: Getting Started with GKE

This project demonstrate how to deployment a Kubernetes cluster on GKE following instructors in the qwiklabs project at [Google Cloud Fundamentals: Getting Started with GKE](https://googlepluralsight.qwiklabs.com/focuses/10840188?parent=lti_session). The aim of this project is to convert the instruction in the project to shell script command that can be deployed easily.

## Steps

- Open exportvars.sh and update the variables as needed

Then you can run `. ./exportvars.sh` followed by `./replacevars.sh` and the `./deploy.sh` to deploy the kubernetes cluster or simple run `./run-deployment.sh` which combines all the step in one go.

After the deployment, the script will pause and export your input to proceed with the scaling the deployment as required by the qwiklabs project, please enter yes to continue with the scaling.
