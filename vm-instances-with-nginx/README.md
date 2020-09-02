# Google Cloud Fundamentals: Getting Started with Compute Engine

This project include configuration to deploy two vm instances, install nginx server and update (replace) the default index file.

### Steps 

- Clone the repository at https://github.com/tutugodfrey/gads-learning-track

- change directory to the project folder

`cd gads-learning-track/vm-instances-with-nginx`

- Deploy the configuration

`./deploy`

The deployment will create firewall rule to allow http traffic

- Test the deployments

In the cloud console navigate to `compute engine` > `vm instance` you should see the two vm instances `my-vm-1` and `my-vm-2`. Click on the external IP address of each to open the site. If the show the nginx page immediately, wait a little while and try again.
