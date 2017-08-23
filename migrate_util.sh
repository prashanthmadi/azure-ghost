#!/bin/bash
[ -e "/home/site/wwwroot/hostingstart.html" ] && rm "/home/site/wwwroot/hostingstart.html"
echo "************started migration***********"
printenv
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