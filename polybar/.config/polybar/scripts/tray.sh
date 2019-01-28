#!/bin/bash

string="tray-position"

if grep ";$string" ${HOME}/.config/polybar/config 1> /dev/null; then
	#sed -e "/$string/ s/^;*//" -i $3
	echo "Adicionando ;"
else
	#sed -e "/$string/ s/^;*/;/" -i $3
	echo "Removendo ;"
fi


