#!/bin/bash
set -e

userdel dev
groupadd -g 1000 jenkins
useradd -m -o -u 1000 -g 1000 -d /home/jenkins -s /bin/bash jenkins

echo 'jenkins:jenkins' | chpasswd

cat >> /etc/sudoers << EOF
jenkins ALL=(ALL) NOPASSWD:ALL
EOF

apt-get install -y rsync

#sw thrift
