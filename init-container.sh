#!/bin/bash
service ssh start
gosu node ghost config --db="mysql" --dbhost="$DB_HOST" --dbname="$DB_NAME" --dbuser="$DB_USER" --dbpass="$DB_PASS" --url="$GHOST_URL"
chown -R node "$GHOST_CONTENT"
/usr/bin/supervisord