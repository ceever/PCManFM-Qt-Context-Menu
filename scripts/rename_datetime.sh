#!/bin/bash
cd "`dirname "$1"`"

### Everything below will go to the file 'rename.log':
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>>rename.log 2>&1
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

ORIG_SEARCH="Date/Time Original"
SEARCH=

for fo in "$@"
do
	if [ -f "$fo" ]
	then
		echo "#$(basename "$fo")" | sed 'y/ /+/'
		STRG=`exiftool "$fo" | grep "$ORIG_SEARCH"`
		if [ -z "$STRG" ]
		then
			if [[ -z "$STRG" ]] && [[ -z "$SEARCH" ]]
			then
				SEARCH=`zenity --entry --title="Rename warning ($(basename "$fo"))" --text="'$ORIG_SEARCH' was not found, but we have found the following\nEXIF 'Date' pairs (key : value):\n\n$(exiftool "$fo" | grep Date)\n\nPlease provide the key to use (for 'grep', mind duplication and always use 'Date'!).\n\nNote, this will be used for all following files, in case '$ORIG_SEARCH' cannot be found.\nUse an arbitrary random string to proactively copy all such files into 'missing/'.\n\nKey to search/use:"`
				if [ 1 -eq $? ]; then exit; fi
			fi
			if [ -n "$SEARCH" ]
			then
				STRG="`exiftool "$fo" | grep "$SEARCH"`"
			fi
		fi
		
		EXT="${fo##*.}"
		if [[ "JPG" == "$EXT" ]] || [[ "JPEG" == "$EXT" ]] || [[ "jpeg" == "$EXT" ]]
		then
			EXT=jpg
		fi
		
		if [ -n "$STRG" ]
		then
			NAME1=`echo $STRG | python3 "$SDIR/datetime_string2name+.py" $SHIFT`.$EXT
			NAME2=`echo $STRG | python3 "$SDIR/datetime_string2name+.py" $(bc <<< "scale=6; $SHIFT+0.00028")`.$EXT
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
		NAME2="`zenity --entry --title="File name warning" --text="File tmp/${NAME1/_/__} (and next: tmp/${NAME2/_/__}) exist(s)!\n\nProvide alternative name (with extension, no folder):"`"
		if [ 1 -eq $? ]; then exit; fi
		if [ -f "tmp/$NAME2" ]; then echo "tmp/$NAME2 seems to exist (4) ... thus, the upcoming 'cp' will probably not execute successfully."; fi
		cp -n "$fo" "tmp/$NAME2";
	fi
done | tee >(zenity --progress --pulsate --auto-close --title="Date/time rename" --text="...")

exit