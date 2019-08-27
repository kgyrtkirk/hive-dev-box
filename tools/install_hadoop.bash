#!/bin/bash

apache_mirror='http://xenia.sote.hu/ftp/mirrors/www.apache.org/'
archive_mirror='https://archive.apache.org/dist/'
set -e
set -x

#FIXME move to basic
apt-get install -y psmisc nano screen sysvbanner

version=3.1.2
bin_dir=hadoop-$version
[ -d "$bin_dir" ] && echo "$bin_dir  already installed" && exit 0

fn=/tmp/hadoop-${version}.tar.gz
wget -nv -O $fn ${apache_mirror}/hadoop/common/hadoop-${version}/hadoop-${version}.tar.gz ||
wget -nv -O $fn ${archive_mirror}/hadoop/common/hadoop-${version}/hadoop-${version}.tar.gz
cd /
tar xzf $fn
rm $fn
rm -f hadoop
ln -s $bin_dir hadoop
