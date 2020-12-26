#!/bin/bash

if [ "$1" == "ebook_small" ]
then
	for fo in "$@"
	do
		if [ -f "$fo" ]
		then
			PN="${fo/.PDF/.pdf}"
			gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dColorImageDownsampleType=/Bicubic -dColorImageResolution=120 -dGrayImageDownsampleType=/Bicubic -dGrayImageResolution=120 -dMonoImageDownsampleType=/Bicubic -dMonoImageResolution=120 -dNOPAUSE -dQUIET -dBATCH -sOutputFile="${PN/.pdf/.sml.pdf}" "$fo"
		fi
	done
else
	for fo in "$@"
	do
		if [ -f "$fo" ]
		then
			PN="${fo/.PDF/.pdf}"
			gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/$1 -dNOPAUSE -dQUIET -dBATCH -sOutputFile="${PN/.pdf/.sml.pdf}" "$fo"
		fi
	done
fi