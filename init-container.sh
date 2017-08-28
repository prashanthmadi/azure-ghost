#!/bin/bash
gosu node ghost config --db="mysql" --dbhost="$DB_HOST" --dbname="$DB_NAME" --dbuser="$DB_USER" --dbpass="$DB_PASS" --url="$GHOST_URL"
gosu node ghost config paths.contentPath "$GHOST_CONTENT"
gosu node ghost config server.host 0.0.0.0
sh /bin/migrate_util.sh
/usr/bin/supervisord