#!/bin/bash -e

apt-get install -y docker.io locales time git-review jq firefox-esr diffstat unzip zip
apt-get install -y mariadb-client postgresql-client  kdiff3
apt install -y default-mysql-client

echo "LC_ALL=en_US.UTF-8" >> /etc/environment
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
locale-gen en_US.UTF-8

cd /tmp
wget -nv https://github.com/bitnami/wait-for-port/releases/download/v1.0/wait-for-port.zip
unzip wait-for-port.zip
mv wait-for-port /usr/bin


sed -i 's/32m/36m/' ~dev/.bashrc


# FIXME: consider setting
#Set hive.tez.container.size=3356;
#Set hive.tez.java.opts=-Xmx2g;
#conf set hive/hive-site hive.tez.container.size 3356
#conf set hive/hive-site hive.tez.java.opts -Xmx2g
# FIXME: scale up mem values?

