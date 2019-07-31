#!/bin/bash

set -e
set -x

hive_version='3.1.1'
tez_version='0.9.1'
apache_mirror='http://xenia.sote.hu/ftp/mirrors/www.apache.org/'


#FIXME move to basic
apt-get install -y psmisc nano screen sysvbanner

version=3.1.1
fn=/tmp/hadoop-${version}.tar.gz
wget -nv -O $fn \
        ${apache_mirror}/hadoop/common/hadoop-${version}/hadoop-${version}.tar.gz
cd /
tar xzf $fn
rm $fn
rm -f hadoop
ln -s hadoop-$version hadoop
