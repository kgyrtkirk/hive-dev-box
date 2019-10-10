#!/bin/bash -e

apt-get install -y docker.io locales time git-review jq firefox-esr diffstat
echo "LC_ALL=en_US.UTF-8" >> /etc/environment
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
locale-gen en_US.UTF-8

sed -i 's/32m/36m/' ~dev/.bashrc


# FIXME: consider setting
#Set hive.tez.container.size=3356;
#Set hive.tez.java.opts=-Xmx2g;
#conf set hive/hive-site hive.tez.container.size 3356
#conf set hive/hive-site hive.tez.java.opts -Xmx2g
# FIXME: scale up mem values?
