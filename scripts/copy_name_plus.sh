#!/bin/bash

i=0
STRG=
for fo in "$@"
do
	if [ -z "$(echo $fo | grep "/./")" ]
	then
		if [ "/./" == "$1" ]
		then
			STRG="$STRG""$(basename "$fo" | rev | cut -f 2- -d "." | rev)"$'\n'
		elif [ "/././" == "$1" ]
		then
			STRG="$STRG""$(basename "$fo")"$'\n'
		elif [ "/./././" == "$1" ]
		then
			STRG="$STRG""$fo"$'\n'
		fi
		i=$((i+1))
	fi
done

echo -n "$STRG" | xclip -r -selection clipboard
if [ 13 -lt $i ]
then
	notify-send -t 5000 -u low -i edit-copy '<h3>Clipboard:</h3>' "$(xclip -selection clipboard -o | head -10)<br>...<br>"
else
	notify-send -t 5000 -u low -i edit-copy '<h3>Clipboard:</h3>' "$(xclip -selection clipboard -o)"
fi