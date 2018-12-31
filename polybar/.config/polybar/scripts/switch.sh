#!/usr/bin/env bash

if [ ! -z $(grep -q "Preto" ${HOME}/.config/polybar/config) ]; then 
    SW=""
    if [ $1 ]; then
    	cat ${HOME}/.config/polybar/preto > ${HOME}/.config/polybar/config
    fi
else
	COR=$(awk -F# '/alert/{print $2;exit}' ${HOME}/.config/polybar/config)
	SW="%{F#${COR}}%{F-}"
    if [ $1 ]; then
    	cat ${HOME}/.config/polybar/branco > ${HOME}/.config/polybar/config
	fi
fi

if [ $1 ]; then
	cat ${HOME}/.config/polybar/principal >> ${HOME}/.config/polybar/config
	${HOME}/.config/polybar/launch.sh
	#export DISPLAY=:0 ; canberra-gtk-play -i trash-empty 2>&1
fi

echo "${SW}"
