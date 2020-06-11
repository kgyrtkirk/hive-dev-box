#!/bin/bash -e

apt-get update
apt-get install -y docker.io locales time git-review jq firefox-esr diffstat unzip zip graphviz
apt-get install -y mariadb-client postgresql-client  kdiff3 golang bash-completion
apt-get install -y default-mysql-client python libxml2-utils rsync lnav xmlstarlet jq colordiff xclip
apt-get clean

echo "LC_ALL=en_US.UTF-8" >> /etc/environment
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
locale-gen en_US.UTF-8

cd /tmp
wget -nv https://github.com/bitnami/wait-for-port/releases/download/v1.0/wait-for-port.zip
unzip wait-for-port.zip
mv wait-for-port /usr/bin


sed -i 's/32m/36m/' ~dev/.bashrc

cat >> ~dev/.bashrc << EOF

alias grep='grep --color=auto'
alias Grep=grep
export USER=dev

EOF

# FIXME: consider setting
#Set hive.tez.container.size=3356;
#Set hive.tez.java.opts=-Xmx2g;
#conf set hive/hive-site hive.tez.container.size 3356
#conf set hive/hive-site hive.tez.java.opts -Xmx2g
# FIXME: scale up mem values?

