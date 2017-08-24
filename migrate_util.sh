#!/bin/bash
[ -e "/home/site/wwwroot/hostingstart.html" ] && rm "/home/site/wwwroot/hostingstart.html"
echo "************started migration***********"
printenv
# move content if it doesn't exist
if [[ "$*" == node*current/index.js* ]] && ! ls $GHOST_CONTENT/* 1>/dev/null 2>&1; then
  cp -R $GHOST_INSTALL/content.orig/* $GHOST_CONTENT/
  knex-migrator-migrate --init --mgpath "$GHOST_INSTALL/current"
fi
echo "************migration ended***********"