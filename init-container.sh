#!/bin/bash
service ssh start
gosu node ghost config --db "mysql" --pname "ghost" --dbhost "$DB_HOST" --dbname "$DB_NAME" --dbuser "$DB_USER" --dbpass "$DB_PASS" paths.contentPath "$GHOST_CONTENT"
chown -R node "$GHOST_CONTENT"
/usr/bin/supervisord