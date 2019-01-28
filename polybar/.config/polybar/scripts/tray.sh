#!/bin/bash

string=';tray-position'

if grep "$string" ${HOME}/.config/polybar/config 1> /dev/null; then
	sed -e "/$string/ s/^;*/;/" -i ${HOME}/.config/polybar/config
	echo "Removendo ;"
else
	sed -e "/$string/ s/^;*//" -i ${HOME}/.config/polybar/config
	echo "Adicionando ;"
fi


