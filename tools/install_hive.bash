#!/bin/bash

hive_version='3.1.1'
tez_version='0.9.1'
apache_mirror='http://xenia.sote.hu/ftp/mirrors/www.apache.org/'

set -e

#FIXME move to basic
apt-get install -y psmisc nano screen sysvbanner

version=3.1.1
fn=/tmp/hive-${version}.tar.gz
wget -nv -O $fn \
	http://xenia.sote.hu/ftp/mirrors/www.apache.org/hive/hive-${version}/apache-hive-${version}-bin.tar.gz
cd /
tar xzf $fn
rm $fn
rm -f hive
ln -s apache-hive-$version-bin hive

