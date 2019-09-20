#!/bin/bash

set -e
apt-get install -y mariadb-server default-mysql-client

sudo mysql << EOF
DROP DATABASE IF EXISTS metastore;
DROP USER IF EXISTS 'hive'@'localhost';
create database metastore;
CREATE USER 'hive'@'localhost' IDENTIFIED BY 'mypassword';
REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'hive'@'localhost';
GRANT ALL PRIVILEGES ON metastore.* TO 'hive'@'localhost';
FLUSH PRIVILEGES;
EOF

cat > ~vagrant/.my.cnf << EOF
[client]
user=hive
password=mypassword
database=metastore
EOF

mkdir -p /apps/lib
cd /apps/lib
[ ! -f mysql-connector-java-8.0.17.jar ] && wget -nv https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.17/mysql-connector-java-8.0.17.jar
