#!/bin/bash

sudo apt-get install postgresql
sudo -u postgres psql -c "CREATE USER hiveuser WITH PASSWORD 'mypassword'"
sudo -u postgres createdb metastore -O hiveuser

echo localhost:5432:metastore:hiveuser:mypassword > ~dev/.pgpass
chmod 600 ~dev/.pgpass

cat > /etc/profile.d/postgres_def.sh <<EOF
export PGHOST=localhost
export PGUSER=hiveuser
export PGDATABASE=metastore
EOF
