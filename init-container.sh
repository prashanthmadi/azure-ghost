#!/bin/bash
service ssh start
[ -e "/home/site/wwwroot/hostingstart.html" ] && rm "/home/site/wwwroot/hostingstart.html"
gosu node ghost config paths.contentPath "$GHOST_CONTENT"
chown -R node "$GHOST_CONTENT"

echo "************started migration***********"
echo printenv
# move content if it doesn't exist
if ! [ "$(ls -A $GHOST_CONTENT)" ]; then
	baseDir="$GHOST_INSTALL/content.orig"
	for src in "$baseDir"/*/ "$baseDir"/themes/*; do
		src="${src%/}"
		target="$GHOST_CONTENT/${src#$baseDir/}"
		mkdir -p "$(dirname "$target")"
		if [ ! -e "$target" ]; then
			tar -cC "$(dirname "$src")" "$(basename "$src")" | tar -xC "$(dirname "$target")"
		fi
	done
	gosu node knex-migrator-migrate --init --mgpath "$GHOST_INSTALL/current"
fi
echo "************migration ended***********"

/usr/bin/supervisord