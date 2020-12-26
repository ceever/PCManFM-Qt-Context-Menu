#!/bin/sh

loopdevice=$(udisksctl loop-setup -f "$1" | grep -oh '/dev/loop[0-9]')

udisksctl mount -b $loopdevice