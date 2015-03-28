#!/bin/bash

#Script to import Postgres db data via SQL from backup
echo "Importing backup"
cp /myapp/db/latestdbdump.sql.zip /tmp

cd /tmp
unzip /tmp/latestdbdump.sql.zip 

#Run a postgres sql import
PGPASSWORD=$POSTGRES_PASSWORD psql -U $POSTGRES_USER -d myPostgresDB -f latestdbdump.sql -h $DB_PORT_5432_TCP_ADDR
