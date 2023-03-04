#!/bin/bash

if [ "folder" == "$1" ]
then
	cd "`dirname "$2"`"
else
	cd "`dirname "$1"`"
fi

for fo in "$@"
do
	if [ -f "$fo" ]
	then
		echo "#$(basename "$fo")" | sed 'y/ /+/'
		if [ "folder" == "$1" ]
		then
			mkdir -p "${fo%.*}"
			timeout -k 10 10 7z x -aou -o"${fo%.*}" "$fo" > /dev/null
		else
			timeout -k 10 10 7z x -aou "$fo" > /dev/null
		fi
		if [ 0 -ne $? ]
		then
			zenity --error --no-wrap --text="<b><big>Extraction failed for</big>\n\n<tt>$fo</tt></b>\n\n\nEither 7z took too long,\ngot stuck (password),\nor failed otherwise." &
		fi
		sleep 1
	fi
done | zenity --progress --pulsate --auto-close --title="Extracting ..." --text="..."