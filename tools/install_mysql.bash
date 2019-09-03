#!/bin/bash

apt-get install -y libmysql-java

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
cp -L /usr/share/java/mysql-connector-java.jar /apps/lib/