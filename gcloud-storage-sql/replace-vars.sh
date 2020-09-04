#! /bin/bash

sed -i -e 's/ROOT_PASSWORD/'$ROOT_PASSWORD/ './deploy.sh'
sed -i -e 's/PASSWORD/'$PASSWORD/ './deploy.sh'
sed -i -e 's/DB_INSTANCE_ID/'$DB_INSTANCE_ID/ './deploy.sh'
sed -i -e 's/DB_USER/'$DB_USER/ './deploy.sh'
sed -i -e 's/ZONE/'$ZONE/ './deploy.sh'
