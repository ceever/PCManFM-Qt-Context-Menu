#!/bin/bash

cd `xdg-user-dir DESKTOP`

for fo in "$@"
do
	[[ -e "$fo" ]] && ln -s "$fo"
done