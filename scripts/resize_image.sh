#!/bin/bash
cd "`dirname "$1"`"


for fo in "$@"
do
	if [ -f "$fo" ]
	then
		echo "#$(basename "$fo")" | sed 'y/ /+/'
		convert -strip -resize 50% "$fo" "${fo%.*}.sml.${fo##*.}"
	fi
done | zenity --progress --pulsate --auto-close --title="Resizing images" --text="..."