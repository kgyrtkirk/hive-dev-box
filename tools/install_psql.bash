#!/bin/bash

sudo apt-get install postgresql
sudo -u postgres psql -c "CREATE USER hiveuser WITH PASSWORD 'mypassword'"
sudo -u postgres createdb metastore -O hiveuser
