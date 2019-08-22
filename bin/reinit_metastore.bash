#!/bin/bash -ex

D=/data/hive/metastore_db
rm -rf $D
/hive/bin/schematool -dbType derby -initSchema
banner ok
