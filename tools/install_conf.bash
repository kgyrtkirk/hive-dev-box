#!/bin/bash

set -e
set -x

mkdir -p /etc/{hadoop,hive}
cp -r /hadoop/etc/hadoop /etc/
#cp -r /hive/conf/ /etc/hive/

cat >> /etc/screenrc << EOF
shell /bin/bash
EOF

mkdir -p /data/hive /data/log
chown dev /data{,/hive,/log}
chmod 777 /data/hive /data/log

mkdir -p /apps/tez && cp /tez/share/tez.tar.gz /apps/tez/
mkdir -p /apps/lib && cp /hive/lib/derby-*.jar /apps/lib/

# use ssd for docker

# FIXME: fix sdkman
cat > /etc/profile.d/confs.sh << EOF

export HADOOP_CONF_DIR=/etc/hadoop
export HADOOP_LOG_DIR=/data/log
export HADOOP_CLASSPATH=/etc/tez/:/tez/lib/*:/tez/*
export HIVE_CONF_DIR=/etc/hive/

export SDKMAN_DIR="/usr/local/sdkman"
#source "/root/.sdkman/bin/sdkman-init.sh"
source "/usr/local/sdkman/bin/sdkman-init.sh"

function sw_j7() {
        sdk use java 7.0.222-zulu
}

function sw_j8() {
        sdk use java 8.0.212-zulu
}


export PATH=$PATH:/hive/bin:/hadoop/bin

EOF
