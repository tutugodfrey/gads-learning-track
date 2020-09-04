#! /bin/bash

sed -i -e 's/MY_ZONE/'$MY_ZONE/ ./deploy.sh
sed -i -e 's/NUM_NODES/'$NUM_NODES/ ./deploy.sh
