#!/bin/bash

for fo in "$@"
do
	if [ -f "$fo" ]
	then
		cd "`dirname "$fo"`"
		ps2pdf "$fo"
	fi
done