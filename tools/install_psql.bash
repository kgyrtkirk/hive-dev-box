#!/bin/bash

sudo apt-get install postgresql
sudo -u postgres psql -c "CREATE USER hiveuser WITH PASSWORD 'mypassword'"
sudo -u postgres createdb metastore -O hiveuser

exit 0

conf set hive/hive-site javax.jdo.option.ConnectionURL jdbc:postgresql://localhost/metastore
conf set hive/hive-site javax.jdo.option.ConnectionDriverName org.postgresql.Driver
conf set hive/hive-site javax.jdo.option.ConnectionUserName hiveuser
conf set hive/hive-site javax.jdo.option.ConnectionPassword mypassword
