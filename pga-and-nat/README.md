# Implement Private Google Access and Cloud NAT

This project demonstrate how to use Private Google Access and Cloud NAT following instruction from qwiklabs project [Implement Private Google Access and Cloud NAT](https://googlepluralsight.qwiklabs.com/focuses/10944146?parent=lti_session). The iam of this project is to convert the instructions from the project to a scripted form that is easy to deploy

## Steps

- Clone the repository

`git clone https://github.com/tutugodfrey/gad-learning-track`

- Change working directory

`cd pga-and-nat`

- Initialize the deploy.sh

`. ./deploy.sh`

This will make the functions inside the script avialable for use when following when provision your resources. It will also update the `startup-script.sh` with the bucket name `BUCKET` which should default to the project id. The startup script will create the file config.sh in the file in the vm which will be use for running the instruction specific to the vm

From here you can run each of the function to create and interact with resources following the instruction from the qwiklabs project.