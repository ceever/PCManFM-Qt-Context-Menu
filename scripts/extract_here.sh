#!/bin/bash
cd "`dirname "$1"`"


for fo in "$@"
do
	if [ -f "$fo" ]
	then
		timeout -k 10 7z x -aou "$fo"
		if [ 0 -ne $? ]
		then
			zenity --error --no-wrap --text="<b><big>Extraction failed for</big>\n\n<tt>$fo</tt></b>\n\n\nEither 7z took too long,\ngot stuck (password),\nor failed otherwise."
		fi
	fi
done