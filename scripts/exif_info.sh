#!/bin/bash

exiftool "$1" | zenity --title="EXIF: `basename "$1"`" --text-info --height=500 --width=600
