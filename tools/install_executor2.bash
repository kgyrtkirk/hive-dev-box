#!/bin/bash
set -e

UID=${1:-1000}

userdel dev
groupadd -g $UID jenkins
useradd -m -o -u $UID -g $UID -d /home/jenkins -s /bin/bash jenkins

echo 'jenkins:jenkins' | chpasswd

cat >> /etc/sudoers << EOF
jenkins ALL=(ALL) NOPASSWD:ALL
EOF


cat >> ~jenkins/.bashrc << EOF

alias grep='grep --color=auto'
alias Grep=grep
export USER=jenkins

EOF

apt-get install -y rsync

#sw thrift
