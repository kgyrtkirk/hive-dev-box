#!/bin/bash

set -e
set -x

git config --global user.email foo@acme.com
git config --global user.name "John Doe"

mkdir -p /etc/{hadoop,hive}
#cp -r /hadoop/etc/hadoop /etc/
#cp -r /hive/conf/ /etc/hive/

conf init

for u in root vagrant dev hive;do
        conf set hadoop/core-site hadoop.proxyuser.${u}.groups '*'
        conf set hadoop/core-site hadoop.proxyuser.${u}.hosts '*'
done
conf set hadoop/core-site hadoop.tmp.dir '/data/hadoop-${user.name}'

conf set hadoop/yarn-site yarn.nodemanager.aux-services mapreduce_shuffle
conf set hadoop/yarn-site yarn.nodemanager.aux-services.mapreduce_shuffle.class org.apache.hadoop.mapred.ShuffleHandler
conf set hadoop/yarn-site yarn.nodemanager.resource.memory-mb 8192
conf set hadoop/yarn-site yarn.nodemanager.resource.cpu-vcores 2
conf set hadoop/yarn-site yarn.nodemanager.disk-health-checker.max-disk-utilization-per-disk-percentage 99

conf set hadoop/hdfs-site dfs.replication 1

conf set hadoop/capacity-scheduler yarn.scheduler.capacity.maximum-am-resource-percent 0.6
conf set hadoop/capacity-scheduler yarn.scheduler.capacity.resource-calculator org.apache.hadoop.yarn.util.resource.DefaultResourceCalculator
conf set hadoop/capacity-scheduler yarn.scheduler.capacity.root.queues default
conf set hadoop/capacity-scheduler yarn.scheduler.capacity.root.default.capacity 100
conf set hadoop/capacity-scheduler yarn.scheduler.capacity.root.default.user-limit-factor 1
conf set hadoop/capacity-scheduler yarn.scheduler.capacity.root.default.maximum-capacity 100
conf set hadoop/capacity-scheduler yarn.scheduler.capacity.root.default.state RUNNING
#yarn.scheduler.capacity.root.default.acl_submit_applications '*'
#yarn.scheduler.capacity.root.default.acl_administer_queue '*'
#yarn.scheduler.capacity.root.default.acl_application_max_priority '*'
#yarn.scheduler.capacity.root.default.maximum-application-lifetime -1
#yarn.scheduler.capacity.root.default.default-application-lifetime -1
#yarn.scheduler.capacity.node-locality-delay 40
#yarn.scheduler.capacity.rack-locality-additional-delay -1
#yarn.scheduler.capacity.queue-mappings ''

conf set tez/tez-site tez.lib.uris '${fs.defaultFS}/apps/tez/tez.tar.gz'
#conf set tez/tez-site tez.am.resource.memory.mb 512

conf set hive/hive-site hive.metastore.warehouse.dir /data/hive/warehouse
# FIXME: probably defunct
conf set hive/hive-site hive.metastore.local true
conf set hive/hive-site hive.user.install.directory file:///tmp
conf set hive/hive-site hive.execution.engine tez
conf set hive/hive-site hive.log.explain.output true
conf set hive/hive-site hive.in.test true
conf set hive/hive-site hive.exec.scratchdir /data/hive
# FIXME: this might not needed...
conf set hive/hive-site yarn.nodemanager.disk-health-checker.max-disk-utilization-per-disk-percentage 99


mkdir -p /data/hive /data/log
chown dev /data{,/hive,/log}
chmod 777 /data/hive /data/log

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
