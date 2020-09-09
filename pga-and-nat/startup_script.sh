#! /bin/bash

touch ./config.sh

my_bucket=BUCKET

create_config_file () {
  echo "#! /bin/bash

update_package_index () {
  # This should work in cloud shell
  # But fails for vm without external IP address
  # We us cloud nat to enable vm access the external network for update and the like. 
  # But external traffic cannot get to the vm by default, only the vm can initiate a connection
  sudo apt-get update
}

use_pga () {
  # This will work in cloud shell by default.
  # But for a vm, Private google access needs to be enabled which is what we do in enable_pga
  # After that this should work for the vm
  gsutil cp gs://${my_bucket}/*.svg .
}

use_funct () {
  echo you can see the function works
}

echo "file created"

" > ./config.sh
}

create_config_file # Create the config.sh file
chmod +x ./config.sh
. ./config.sh
echo it works again
