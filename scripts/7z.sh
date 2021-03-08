#!/bin/bash

OPTS=()
for i in "$@"
do
	OPTS+=(\"$i\")
done

cd "`dirname "$1"`"

FN=\"$(basename "${1%.*}").7z\"

eval 7z a -y -t7z -m0=lzma -mx=9 -mfb=64 -md=32m -ms=on $FN ${OPTS[@]}