#!/usr/bin/env bash

excl=("/dev/sda1")

for d in /dev/sda*; do
	tipo=$(udisksctl info -b $d | grep IdType | awk '{print $2}')
	montagem=$(udisksctl info -b $d | grep MountPoints | awk '{print $2}')
	if [ "$tipo" == "ntfs" ] && [ "$montagem" != "$excl" ]; then
		udisksctl mount -b $d
		notify-send "AutoMount" "$d montado em $montagem"
	fi
done
