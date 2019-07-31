#!/bin/bash
set -e

sed -i 's/deb.debian.org/ftp.hu.debian.org/' /etc/apt/sources.list


debconf-set-selections <(cat << EOF
keyboard-configuration	keyboard-configuration/variant	select	English (US)
EOF
)

apt-get update
apt-get install -y \
        wget curl nano gnupg lsb-release sysvbanner git \
        default-mysql-client screen psmisc netcat psmisc nano screen sysvbanner #xbase-clients
apt-get clean

useradd -m -o -u 1000 -g 1000 -d /home/dev -s /bin/bash dev

echo 'root:root' | chpasswd
echo 'dev:dev' | chpasswd

# setup sudo
apt-get install -y sudo wget vim tree
adduser dev sudo
cat >> /etc/sudoers << EOF
# dev can do anything
dev ALL=(ALL) NOPASSWD:ALL
EOF
