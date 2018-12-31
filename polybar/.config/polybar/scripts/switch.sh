#!/usr/bin/env bash

grep -Fx "Preto" ${HOME}/.config/polybar/config

if [ $? = 1 ]; then 
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
	i3-msg restart
fi

echo "${SW}"
