#!/bin/bash -e

[ "$EUID" != 0 ] && sudo $0 "$@" && exit 0

apache_mirror='http://xenia.sote.hu/ftp/mirrors/www.apache.org/'
archive_mirror='https://archive.apache.org/dist/'

err_report() {
    echo "Error on line $1"
}

trap 'err_report $LINENO' ERR

function dl() {

	[ -f "$1" ] && echo "already downloaded $1" && return 0
	f=$1
	shift
	while [ "$1" != "" ];do
		wget -nv -O "$f" "$1" && return 0
		shift
	done
	echo "unable to download $f"
	return 1
}

function activate() {
	echo "@ activating: $2 for $1"
	rm -f "$1"
	ln -s "$2" "$1"

}

cd /
component="${1}"
shift
case "$component" in
	hive-dev)
		d=/hive-dev/packaging/target/apache-hive-*-SNAPSHOT-bin/apache-hive-*-SNAPSHOT-bin/
		[ ! -d $d ] && echo "expected a directory at: $d" && exit 1
		activate hive $d
	;;
	hive)
		version=${1:-3.1.2}
		bin_dir=apache-hive-$version-bin
		if [ -d "$bin_dir" ];then
			echo "$bin_dir already installed"
		else
			fn=/tmp/hive-${version}.tar.gz
			dl $fn \
				$apache_mirror/hive/hive-${version}/apache-hive-${version}-bin.tar.gz	\
				$archive_mirror/hive/hive-${version}/apache-hive-${version}-bin.tar.gz
			tar xzf $fn
			#rm $fn
		fi
		activate $component $bin_dir
	;;
	hadoop)
		version=${1:-3.1.2}
		bin_dir=hadoop-$version
		if [ -d "$bin_dir" ];then
			echo "$bin_dir already installed"
		else
			fn=/tmp/hadoop-${version}.tar.gz
			dl $fn \
				${apache_mirror}/hadoop/common/hadoop-${version}/hadoop-${version}.tar.gz	\
				${archive_mirror}/hadoop/common/hadoop-${version}/hadoop-${version}.tar.gz
			cd /
			tar xzf $fn
			#rm $fn
		fi
		activate $component $bin_dir
	;;
	tez)
		version=${1:-0.9.1}
		bin_dir=apache-tez-$version-bin
		if [ -d "$bin_dir" ];then
			echo "$bin_dir already installed"
		else
			fn=/tmp/tez-${version}.tar.gz
			dl $fn \
				${apache_mirror}/tez/${version}/apache-tez-${version}-bin.tar.gz
			cd /
			tar xzf $fn
			#rm $fn
		fi
		activate $component $bin_dir
	;;
	*)
		echo "see source.."
		exit 1
	;;
esac
