# Working with Virtual Machines

This aim of this project is to convert the qwiklab project [Working with Virtual Machines](https://googlepluralsight.qwiklabs.com/focuses/10972181?parent=lti_session) to a scripted form that easy to deploy.

## Steps

- Clone the repository

`git clone https://github.com/tutugodfrey/gads-learning-track`

- Change working directory

`cd gads-learning-track/working-with-vms`

- Provision the script for execution of functions therein

`. ./deploy.sh`

This will provision the variables and functions in the script in the current shell for execution, it will also update startup_script.sh by replacing BUCKETNAME with the projectid if run from within cloud shell.

startup_script.sh contains instruction to create config.sh file which contain functions that group instructions to be run in the vm. This is passed as metadata file to the command used to create the vm

When you ssh to the vm, you should find the config.sh at `~/` provision the script by running `. ./config.sh` Then you can run the functions contains within the script following the instructions in the qwiklabs project.
