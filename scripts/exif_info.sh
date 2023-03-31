#!/bin/bash

exiftool "$1" | zenity --text-info --height=500 --width=600