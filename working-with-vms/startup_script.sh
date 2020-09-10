#! /bin/bash

cat > config.sh << END
#! /bin/bash

BUCKET_NAME=BUCKETNAME
export YOUR_BUCKET_NAME=BUCKET_NAME

prepare_disk () {
  sudo mkdir -p /home/minecraft
  sudo mkfs.ext4 -F -E lazy_itable_init=0,\
  lazy_journal_init=0,discard \
/dev/disk/by-id/google-minecraft-disk
#   sudo mkfs.ext4 -F -E lazy_itable_init=0,\
# lazy_journal_init=0,discard \
# /dev/disk/by-id/google-minecraft-disk
  sudo mount -o discard,defaults /dev/disk/by-id/google-minecraft-disk /home/minecraft
}

install_jre () {
  sudo apt-get update
  sudo apt-get install -y default-jre-headless
  sudo apt-get install wget
  sudo wget https://launcher.mojang.com/v1/objects/d0d0fe2b1dc6ab4c65554cb734270872b72dadd6/server.jar
  sudo java -Xmx1024M -Xms1024M -jar server.jar nogui
  sed -i -e 's/eula=false/'eula=true/ eula.txt
}

create_virtual_terminal () {
  sudo apt-get install -y screen
  sudo screen -S mcs java -Xmx1024M -Xms1024M -jar server.jar nogui
  sudo screen -r mcs
}

make_bucket () {
  gsutil mb gs://$YOUR_BUCKET_NAME-minecraft-backup
}

create_backup_script () {
  cd /home/minecraft
  sudo nano /home/mincraft/backup.sh

  echo "#! /bin/bash
  #!/bin/bash
  screen -r mcs -X stuff '/save-all\n/save-off\n'
  /usr/bin/gsutil cp -R ${BASH_SOURCE%/*}/world gs://${YOUR_BUCKET_NAME}-minecraft-backup/$(date "+%Y%m%d-%H%M%S")-world
  screen -r mcs -X stuff '/save-on\n'
  " > /home/minecraft/backup.sh

  sudo chmod 755 /home/minecraft/backup.sh
}

test_backup () {
  . /home/minecraft/backup.sh
}

schedule_cron_job () {
  sudo crontab -e
  0 */4 * * * /home/minecraft/backup.sh
}

stop_screen () {
  sudo screen -r -X stuff '/stop\n'
}
END

sudo cp config.sh ~
cd ~
. ./config.sh




echo "#! /bin/bash
  sudo screen -r mcs -X stuff '/save-all\n/save-off\n'
  sudo /usr/bin/gsutil cp -R /tmp/metadata-scripts144557578/world gs://qwiklabs-gcp-00-63653a2bb6ae-minecraft-backup/20200910-130513-world
  sudo screen -r mcs -X stuff '/save-on\n'
" > /home/minecraft/backup.sh