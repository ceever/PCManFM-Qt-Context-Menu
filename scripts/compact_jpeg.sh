#!/bin/bash
cd "`dirname "$1"`"

### Everything below will go to the file 'compress.log':
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>compact.log 2>&1
###

mkdir -p "tmp"

for fo in "$@"
do
	if [ -f "$fo" ]
	then
		convert -quality 96 "$fo" tmp/tmp.jpg
		new=$(ls -s tmp/tmp.jpg | cut -d' ' -f1)
		old=$(ls -s "$fo" | cut -d' ' -f1)
		if [ 90 -gt $((new*100/old)) ]
		then
			echo "$fo ... keeping. New size: $((new*100/old)) %"
			if [ -f "tmp/$(basename "$fo")" ]; then echo "tmp/$(basename "$fo") seems to exist ... thus, the upcoming 'mv' will probably not execute successfully."; fi
			mv -n tmp/tmp.jpg "tmp/$(basename "$fo")"
		else
			echo "$fo ... no use. (Compacted size: $((new*100/old)) %)"
			rm tmp/tmp.jpg
		fi
	fi
done

#echo -ne "\nFinished? Press <ENTER>: "
#read ttt
exit