#!/bin/bash -e

sed -i 's/deb.debian.org/ftp.hu.debian.org/' /etc/apt/sources.list


debconf-set-selections <(cat << EOF
keyboard-configuration	keyboard-configuration/variant	select	English (US)
EOF
)

apt-get update
apt-get install -y \
        wget curl nano gnupg lsb-release sysvbanner git \
        psmisc nano screen sysvbanner net-tools procps \
        screen psmisc netcat psmisc nano screen sysvbanner \
        make gcc g++ \
        locales time git-review jq diffstat unzip zip docker.io \
        firefox-esr graphviz \
        mariadb-client postgresql-client kdiff3 \
        default-mysql-client \
        xbase-clients libgtk3.0 software-properties-common \
        docker.io locales time git-review jq firefox-esr diffstat unzip zip graphviz \
        mariadb-client postgresql-client  kdiff3 golang bash-completion \
        default-mysql-client python libxml2-utils rsync lnav xmlstarlet jq colordiff xclip sudo wget vim tree

groupadd -f -g 1000 dev
useradd -m -o -u 1000 -g 1000 -d /home/dev -s /bin/bash dev

echo 'root:root' | chpasswd
echo 'dev:dev' | chpasswd

# setup sudo
adduser dev sudo
cat >> /etc/sudoers << EOF
# dev can do anything
dev ALL=(ALL) NOPASSWD:ALL
EOF

echo "LC_ALL=en_US.UTF-8" >> /etc/environment
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
locale-gen en_US.UTF-8

cd /tmp
wget -nv https://github.com/bitnami/wait-for-port/releases/download/v1.0/wait-for-port.zip
unzip wait-for-port.zip
mv wait-for-port /usr/bin
rm wait-for-port.zip

sed -i 's/32m/36m/' ~dev/.bashrc

cat >> ~dev/.bashrc << EOF

alias grep='grep --color=auto'
alias Grep=grep
export USER=dev

EOF

/tools/build_cleanup
