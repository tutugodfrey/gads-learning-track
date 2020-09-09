# VPC Networking

This project is to demonstrate how to create vpc networks on Google cloud. The project follows the instruction in the qwiklabs project [VPC Networking](https://googlepluralsight.qwiklabs.com/focuses/10920774?parent=lti_session). The objective of the project is to convert the instructions from the qwiklabs project to a scripted to that is easy to deploy. For this project, different sections of the instructions has been abstracted to functions which you can run in sequence

## Steps

To complete the instructions in the project do the following

- Intialize the shell script

`. ./deploy`

- Call the following functions

  - delete_default_network
  - attempt_vm_creation
  - create_mynetwork
  - convert_mynetwork_to_custom
  - create_managenmentnet
  - create_privatenet
  - create_firewall_rules
  - create_network_compute_instances

