#!/bin/bash

n=0

for fo in "$@"
do
	if [ -f "$fo" ]
	then
		k=$(set -- `pdfinfo "$fo" | grep "Pages:"`; echo ${@: 2:1})
		n=$((n+k))
		echo "#Pages: $n"
	fi
done | zenity --progress --pulsate --title="Counting pages" --text="..."