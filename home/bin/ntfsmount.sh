#!/usr/bin/env bash

function contem() {
    local n=$#
    local valor=${!n}
    for ((i=1;i < $#;i++)) {
        if [ "${!i}" == "${valor}" ]; then
            echo "s"
            return 0
        fi
    }
    echo "n"
    return 1
}

excl=("/dev/sda1")

for d in /dev/sda*; do
	tipo=$(udisksctl info -b $d | grep IdType | awk '{print $2}')
	montagem=$(udisksctl info -b $d | grep MountPoints | awk '{print $2}')
	if [ "$tipo" == "ntfs" ] && [ $(contem "${excl[@]}" $d) == "n" ] && [ "$montagem" == "" ]; then
		udisksctl mount -b $d
		montagem=$(udisksctl info -b $d | grep MountPoints | awk '{print $2}')
		notify-send "AutoMount" "$d montado em $montagem"
	fi
done
