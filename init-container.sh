#!/bin/bash
service ssh start
ghost config --db="mysql" --dbhost="$DB_HOST" --dbname="$DB_NAME" --dbuser="$DB_USER" --dbpass="$DB_PASS" --url="$GHOST_URL"
ghost config paths.contentPath "$GHOST_CONTENT"
sh /bin/migrate_util.sh
/usr/bin/supervisord