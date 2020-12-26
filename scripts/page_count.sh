#!/bin/bash

n=0

for fo in "$@"
do
	k=$(set -- `pdfinfo "$fo" | grep "Pages:"`; echo ${@: 2:1})
	n=$((n+k))
done

zenity --info --text="Pages: $n"