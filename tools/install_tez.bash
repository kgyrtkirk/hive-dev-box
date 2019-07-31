#!/bin/bash

apache_mirror='http://xenia.sote.hu/ftp/mirrors/www.apache.org/'

set -e

#FIXME move to basic
apt-get install -y psmisc nano screen sysvbanner procps 

version=0.9.1
bin_dir=apache-tez-$version-bin
[ -d "$bin_dir" ] && echo "$bin_dir  already installed" && exit 0

fn=/tmp/tez-${version}.tar.gz
wget -nv -O $fn \
	${apache_mirror}/tez/${version}/apache-tez-${version}-bin.tar.gz --no-check-certificate

cd /
tar xzf $fn
rm $fn
rm -f tez
ln -s $bin_dir tez

