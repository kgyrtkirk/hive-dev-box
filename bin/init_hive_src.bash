#!/bin/bash -e

[ "$1" == "" ] && echo "no name?!" && exit 1

n=$1

git clone git@github.com:apache/hive $n
(
    cd $n
    git checkout -b $n
)
mkdir ws-$n
cd ws-$n
tar xzf /hive-dev-box/tools/def_ws.tgz
git reset --hard

