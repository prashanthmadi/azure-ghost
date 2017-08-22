#!/bin/bash
service ssh start
gosu node ghost config --db="mysql" --dbhost="$DB_HOST" --dbname="$DB_NAME" --dbuser="$DB_USER" --dbpass="$DB_PASS" --url="$GHOST_URL"
gosu node ghost config paths.contentPath "$GHOST_CONTENT"
chown -R node "$GHOST_CONTENT"
sh /bin/migrate_util.sh
/usr/bin/supervisord