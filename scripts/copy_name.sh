#!/bin/bash

if [ "namext" == "$1" ]
then
	basename "$2" | xclip -r -selection clipboard
elif [ "folder" == "$1" ]
then
	echo "$(dirname "$2")/" | xclip -r -selection clipboard
elif [ "path" == "$1" ]
then
	echo "$2" | xclip -r -selection clipboard
else
	FILE=`basename "$2"`
	if [ "." == "${FILE:0:1}" ]
	then
		FILE="${FILE:1}"
	fi

	if [ "name" == "$1" ]
	then
		echo "$FILE" | rev | cut -f 2- -d "." | rev | xclip -r -selection clipboard
	elif [ "1st" == "$1" ]
	then
		echo "$FILE" | rev | cut -f 2- -d "." | rev | cut -f 1 -d " " | xclip -r -selection clipboard
	elif [ "2nd" == "$1" ]
	then
		TMP=`echo "$FILE" | rev | cut -f 2- -d "." | rev | cut -f 2 -d " " -s`
		if [ -n "$TMP" ]
		then
			echo "$TMP" | xclip -r -selection clipboard
		else
			exit 2
		fi
	elif [ "3rd" == "$1" ]
	then
		TMP=`echo "$FILE" | rev | cut -f 2- -d "." | rev | cut -f 3 -d " " -s`
		if [ -n "$TMP" ]
		then
			echo "$TMP" | xclip -r -selection clipboard
		else
			exit 2
		fi
	elif [ "last" == "$1" ]
	then
		echo "$FILE" | rev | cut -f 2- -d "." | cut -f 1 -d " " | rev | xclip -r -selection clipboard
	fi

fi

notify-send -t 5000 -u low -i edit-copy '<h3>Clipboard:</h3>' "<center>$(xclip -selection clipboard -o)</center>"