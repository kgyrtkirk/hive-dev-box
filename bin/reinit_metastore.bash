#!/bin/bash

set -e
#killall java
rm -rf /home/vagrant/metastore_db
/hive/bin/schematool -dbType derby -initSchema
banner ok
