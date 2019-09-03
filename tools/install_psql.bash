#!/bin/bash -e

sudo apt-get install postgresql
sudo -u postgres psql -c "CREATE USER hiveuser WITH PASSWORD 'mypassword'"
sudo -u postgres createdb metastore -O hiveuser

# FIXME use dev instead of vagrant
echo localhost:5432:metastore:hiveuser:mypassword > ~vagrant/.pgpass
chown vagrant ~vagrant/.pgpass
chmod 600 ~vagrant/.pgpass

cat > /etc/profile.d/postgres_def.sh <<EOF
export PGHOST=localhost
export PGUSER=hiveuser
export PGDATABASE=metastore
EOF
