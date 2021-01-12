#!/bin/bash
cd "`dirname "$1"`"


for fo in "$@"
do
	if [ -f "$fo" ]
	then
		convert -strip -resize 50% "$fo" "${fo%.*}.sml.${fo##*.}"
	fi
done