#!/bin/bash -e

mkdir /reference
cd /reference

init() {
	N=$1
	shift
	mkdir $N
	cd $N
	git init .
	for n in $*;do
		git remote add $n https://github.com/$n/hive
	done
	git remote -v
	git fetch --all
}

echo $GITHUB_USER
echo init hive apache $*

init hive apache $*

