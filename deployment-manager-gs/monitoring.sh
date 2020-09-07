#! /bin/bash

curl -sSO https://dl.google.com/cloudagents/add-monitoring-agent-repo.sh
sudo bash add-monitoring-agent-repo.sh
sudo apt-get update

sudo apt-get install stackdriver-agent -y
sudo service stackdriver-agent start
sudo service stackdriver-agent status

# sudo service stackdriver-agent stop # to stop

curl -sSO https://dl.google.com/cloudagents/add-logging-agent-repo.sh
sudo bash add-logging-agent-repo.sh
sudo apt-get update

sudo apt-get install google-fluentd -y
sudo apt-get install -y google-fluentd-catch-all-config
# sudo apt-get install -y google-fluentd-catch-all-config-structured
sudo service google-fluentd start
sudo service google-fluentd status

# sudo service stackdriver-agent start # to stop the service