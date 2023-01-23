#!/bin/bash

for fo in "$@"
do
	if [ -f "$fo" ]
	then
		echo "#$(basename "$fo")" | sed 'y/ /+/'
		PN="${fo/.PDF/.pdf}"
		cd "`dirname "$fo"`"
		pdftk "$fo" rotate 1-end$1 output "${PN/.pdf/.$1.pdf}"
	fi
done | zenity --progress --pulsate --auto-close --title="Rotating PDFs" --text="..."