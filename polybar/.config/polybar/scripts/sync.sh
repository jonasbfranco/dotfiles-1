#!/usr/bin/env bash

user="nginx"
host="hera"
local="${HOME}/htdocs/"
config="${HOME}/.config/polybar/configs/sync.conf"
iconeOK="${HOME}/.local/share/icons/elementary/preferences-system-network.png"
iconeERRO="${HOME}/.local/share/icons/elementary/network-error.png"

if [[ "${1}" == "-c" ]]; then
	if [ ! -d $trash_temp ]; then
		mkdir $trash_temp
	fi

	cp -rf ${trash_dir}/files ${trash_temp}/
	cp -rf ${trash_dir}/info ${trash_temp}/

	rm -rf ${trash_dir}/files
	rm -rf ${trash_dir}/info

	mkdir ${trash_dir}/files
	mkdir ${trash_dir}/info

	if xset q &>/dev/null; then
		# ls /usr/share/sounds/freedesktop/stereo/
		export DISPLAY=:0 ; canberra-gtk-play -i trash-empty 2>&1
		export DISPLAY=:0 ; notify-send -i $icone "Lixeira" "Lixeira limpa!"
	fi
elif [[ "${1}" == "-u" ]]; then
	xdg-open $trash_dir/files
fi

echo ""