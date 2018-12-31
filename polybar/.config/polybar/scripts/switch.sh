#!/usr/bin/env sh

grep -Fxq "Preto" ${HOME}/.config/polybar/config 2> /dev/null

if [ $? = 0 ]; then 
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
