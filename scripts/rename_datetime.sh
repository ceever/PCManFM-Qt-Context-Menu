#!/bin/bash
cd "`dirname "$1"`"

### Everything below will go to the file 'rename.log':
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>rename.log 2>&1
###

SDIR=`dirname "$0"`

SHIFT=`zenity --entry --text="Adjust timestamp (+/- hours): "`
if [ -z "$SHIFT" ]
then
	SHIFT=0
fi

mkdir -p "tmp"
mkdir -p "missing"

for fo in "$@"
do
	if [ -f "$fo" ]
	then
		STRG=`exiftool "$fo" | grep "Date/Time Original"`
		if [ -n "$STRG" ]
		then
			NAME1=`echo $STRG | python "$SDIR/datetime_string2name+.py" $SHIFT`
			NAME2=`echo $STRG | python "$SDIR/datetime_string2name+.py" $(bc <<< "scale=6; $SHIFT+0.00028")`
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
		echo -n "$fo > tmp/$NAME1.jpg"
		if [ ! -f "tmp/$NAME1.jpg" ]
		then
			echo
			if [ -f "tmp/$NAME1.jpg" ]; then echo "tmp/$NAME1.jpg seems to exist (2) ... thus, the upcoming 'cp' will probably not execute successfully."; fi
			cp -n "$fo" tmp/$NAME1.jpg
			continue
		fi
		if [ ! -f "tmp/$NAME2.jpg" ]
		then
			echo " ... correction tmp/$NAME2.jpg"
			if [ -f "tmp/$NAME2.jpg" ]; then echo "tmp/$NAME2.jpg seems to exist (3) ... thus, the upcoming 'cp' will probably not execute successfully."; fi
			cp -n "$fo" tmp/$NAME2.jpg
			continue
		fi
		echo -n " ... file tmp/$NAME1.jpg (and next: tmp/$NAME2.jpg) exist(s)! Provide name (wo. ext): "
		read NAME2
		if [ -f "tmp/$NAME2.jpg" ]; then echo "tmp/$NAME2.jpg seems to exist (4) ... thus, the upcoming 'cp' will probably not execute successfully."; fi
		cp -n "$fo" tmp/$NAME2.jpg;
	fi
done

#echo -ne "\nFinished? Press <ENTER>: "
#read ttt
exit