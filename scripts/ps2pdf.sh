#!/bin/bash

for fo in "$@"
do
	if [ -f "$fo" ]
	then
		echo "#$(basename "$fo")" | sed 'y/ /+/'
		cd "`dirname "$fo"`"
		ps2pdf "$fo"
	fi
done | zenity --progress --pulsate --auto-close --title="Compacting PDFs" --text="..."