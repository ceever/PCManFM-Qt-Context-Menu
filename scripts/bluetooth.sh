#!/bin/bash
# Also, besides regular files, parses subdirectories and resolves directory symbolic links.
# Symbolic links to files are resolved by blueman automatically.

STRG=
for fo in "$@"
do
	if [ -d "$fo" ]
	then
		while read ff
		do
			echo \"$ff\" >> /tmp/out
			STRG="$STRG \"$ff\""
		done <<< "$(find "`readlink -f "$fo"`" -type f,l)"
	else
		if [[ -f "$fo" ]] || [[ -L "$fo" ]]
		then
			STRG="$STRG \"${fo//\"/\\\"}\""
		fi
	fi
done

eval blueman-sendto ${STRG:1}