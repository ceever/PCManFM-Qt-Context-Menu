#!/bin/bash
# Also, besides regular files, parses subdirectories and resolves directory symbolic links.
# Symbolic links to files are resolved by Thunderbird in any case.

STRG=
for fo in "$@"
do
	if [ -d "$fo" ]
	then
		while read ff
		do
			STRG=$STRG,file://`echo -n "$ff" | perl -lpe 's/([^A-Za-z0-9.\/:])/sprintf("%%%02X", ord($1))/seg'`
		done <<< "$(find "`readlink -f "$fo"`" -type f,l)"
	else
		if [[ -f "$fo" ]] || [[ -L "$fo" ]]
		then
			STRG=$STRG,file://`echo -n "$fo" | perl -lpe 's/([^A-Za-z0-9.\/:])/sprintf("%%%02X", ord($1))/seg'`
		fi
	fi
done

thunderbird -compose "attachment='${STRG:1}'"
