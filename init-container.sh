#!/bin/bash
service ssh start
gosu node ghost config --db="mysql" --dbhost="$DB_HOST" --dbname="$DB_NAME" --dbuser="$DB_USER" --dbpass="$DB_PASS" --url="$GHOST_URL"
gosu node ghost config paths.contentPath "$GHOST_CONTENT"
gosu node ghost config database.pool.max 4
gosu node ghost config database.pool.min 1
# chown -R node "$GHOST_CONTENT"
echo "current directory"
echo $PWD
sh /bin/migrate_util.sh
/usr/bin/supervisord