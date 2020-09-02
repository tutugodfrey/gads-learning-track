#! /bin/bash

sudo apt-get update
sudo apt-get install nginx-light -y
sudo mv index.html > /var/www/html/index.nginx-debian.html
