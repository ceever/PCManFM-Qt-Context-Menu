#!/bin/bash
cd "`dirname "$1"`"

### Everything below will go to the file 'rename.log':
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>rename.log 2>&1
###

SDIR=`dirname "$0"`

SHIFT=`zenity --entry --text="Time adjustment (+/- hours) ... <EMPTY> & OK for '0':"`
if [ 1 -eq $? ]; then exit; fi
if [ -z "$SHIFT" ]
then
	SHIFT=0
fi

mkdir -p "tmp"
mkdir -p "missing"

SEARCH="Date/Time Original"

for fo in "$@"
do
	if [ -f "$fo" ]
	then
		STRG=`exiftool "$fo" | grep "$SEARCH"`
		if [ -z "$STRG" ]
		then
			SEARCH=`zenity --entry --title="Rename warning" --text="'$SEARCH' was not found, but we have found\nthe following EXIF 'Date' pairs (key : value):\n\n$(exiftool "$fo" | grep Date)\n\nPlease provide the key to use (for 'grep', mind duplication but use 'Date'!).\n\nNote, this selection will be used for all following files.\n\nKey to search/use:"`
			if [ 1 -eq $? ]; then exit; fi
			STRG="`exiftool "$fo" | grep "$SEARCH"`"
		fi
		
		EXT="${fo##*.}"
		if [[ "JPG" == "$EXT" ]] || [[ "JPEG" == "$EXT" ]] || [[ "jpeg" == "$EXT" ]]
		then
			EXT=jpg
		fi
		
		if [ -n "$STRG" ]
		then
			NAME1=`echo $STRG | python2 "$SDIR/datetime_string2name+.py" $SHIFT`.$EXT
			NAME2=`echo $STRG | python2 "$SDIR/datetime_string2name+.py" $(bc <<< "scale=6; $SHIFT+0.00028")`.$EXT
		else
			NAME1=
			NAME2=
		fi
		if [ -z "$NAME1" ]
		then
			if [ -f "missing/$(basename "$fo")" ]; then echo "missing/$(basename "$fo") seems to exist (1) ... thus, the upcoming 'cp' will probably not execute successfully."; fi
			cp -n "$fo" missing/
			echo "$fo ... EXIF missing. Copied to missing/ ."
			continue
		fi
		echo -n "$fo > tmp/$NAME1"
		if [ ! -f "tmp/$NAME1" ]
		then
			echo
			if [ -f "tmp/$NAME1" ]; then echo "tmp/$NAME1 seems to exist (2) ... thus, the upcoming 'cp' will probably not execute successfully."; fi
			cp -n "$fo" tmp/$NAME1
			continue
		fi
		if [ ! -f "tmp/$NAME2" ]
		then
			echo " ... correction tmp/$NAME2"
			if [ -f "tmp/$NAME2" ]; then echo "tmp/$NAME2 seems to exist (3) ... thus, the upcoming 'cp' will probably not execute successfully."; fi
			cp -n "$fo" tmp/$NAME2
			continue
		fi
		echo -n " ... file tmp/$NAME1 (and next: tmp/$NAME2) exist(s)! Provide name (with extension): "
		read NAME2
		if [ -f "tmp/$NAME2" ]; then echo "tmp/$NAME2 seems to exist (4) ... thus, the upcoming 'cp' will probably not execute successfully."; fi
		cp -n "$fo" tmp/$NAME2;
	fi
done

#echo -ne "\nFinished? Press <ENTER>: "
#read ttt
exit