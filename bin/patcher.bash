#!/bin/bash
set -x
set -e

C=${1:-hive}
V=${2:-3.0.0.0}
PF=/tmp/.patcher

wget -nv -O $PF http://s3.amazonaws.com/dev.hortonworks.com/HDP/centos6/${V:0:1}.x/PATCH_FILES/$V/patch_files/${C}-source.patch ||
wget -nv -O $PF http://s3.amazonaws.com/dev.hortonworks.com/HDP/centos7/${V:0:1}.x/PATCH_FILES/$V/patch_files/${C}-source.patch ||
wget -nv -O $PF http://s3.amazonaws.com/dev.hortonworks.com/HDP/ubuntu14/${V:0:1}.x/PATCH_FILES/$V/patch_files/${C}-source.patch  ||
wget -nv -O $PF http://s3.amazonaws.com/dev.hortonworks.com/HDP/suse11sp3/${V:0:1}.x/PATCH_FILES/$V/patch_files/${C}-source.patch  ||
wget -nv -O $PF http://s3.amazonaws.com/dev.hortonworks.com/HDP/debian7/${V:0:1}.x/PATCH_FILES/$V/patch_files/${C}-source.patch 
git apply -3 -p1 $PF
git commit -m "HWX_PATCH" `find . -name pom.xml`
