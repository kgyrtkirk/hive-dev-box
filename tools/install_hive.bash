#!/bin/bash

set -e

version=3.1.1
bin_dir=apache-hive-$version-bin
[ -d "$bin_dir" ] && echo "$bin_dir  already installed" && exit 0

fn=/tmp/hive-${version}.tar.gz
wget -nv -O $fn \
	http://xenia.sote.hu/ftp/mirrors/www.apache.org/hive/hive-${version}/apache-hive-${version}-bin.tar.gz
cd /
tar xzf $fn
rm $fn
rm -f hive
ln -s $bin_dir hive

