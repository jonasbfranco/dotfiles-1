#!/usr/bin/env bash

COR=$(awk -F# '/alert/{print $2;exit}' ${HOME}/.config/polybar/config)
TRASH_DIRECTORY="${HOME}/.local/share/Trash"
TRASH_TEMP="/tmp/lixo"
icone="${HOME}/.local/share/icons/elementary/user-trash.png"

if [[ "${TRASH_DIRECTORY}" = "" ]]; then
  TRASH_DIRECTORY=${XDG_DATA_HOME:-"${HOME}/.local/share/Trash"}
fi

if [[ "${1}" == "-x" ]]; then
	if [ ! -d $TRASH_TEMP ]; then
		mkdir $TRASH_TEMP
	fi

	cp -rf ${TRASH_DIRECTORY}/files ${TRASH_TEMP}/
	cp -rf ${TRASH_DIRECTORY}/info ${TRASH_TEMP}/

	rm -rf ${TRASH_DIRECTORY}/files
	rm -rf ${TRASH_DIRECTORY}/info

	mkdir ${TRASH_DIRECTORY}/files
	mkdir ${TRASH_DIRECTORY}/info

	if xset q &>/dev/null; then
		# ls /usr/share/sounds/freedesktop/stereo/
		export DISPLAY=:0 ; canberra-gtk-play -i trash-empty 2>&1
		export DISPLAY=:0 ; notify-send -i $icone "Lixeira" "Lixeira limpa!"
	fi
elif [[ "${1}" == "-o" ]]; then
	xdg-open $TRASH_DIRECTORY/files
fi

TRASH_COUNT=$(ls -U -1 "${TRASH_DIRECTORY}/files" | wc -l)

if [[ ${TRASH_COUNT} -gt 0 ]]; then
	s="%{F#${COR}}%{F-} ${TRASH_COUNT}"
else
	s=""
fi

echo "${s}"
