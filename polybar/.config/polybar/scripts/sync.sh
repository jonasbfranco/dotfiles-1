#!/usr/bin/env bash

editor="subl"
user="nginx"
host="hera"
local="${HOME}/htdocs/"
config="${HOME}/.config/polybar/configs/sync.conf"
iconeOK="${HOME}/.local/share/icons/elementary/preferences-system-network.png"
iconeERRO="${HOME}/.local/share/icons/elementary/network-error.png"

largura() {
	set "$(printf '...%s\b\b...\n' "$1" | col -b)"
	echo "$((${#1} - 4))"
}

if [[ "${1}" == "-c" ]]; then
	$editor $config
elif [[ "${1}" == "-u" ]]; then
	if [ -f $config ]; then
		config=$(cat $config)
		while IFS= read -r site; do
			titulo="Atualizar o site ${site}?"
			#l=$(largura "$titulo")
			l=$(echo $titulo | wc -c)
	    	confirma=$(echo -e "Sim\nNão" | rofi -p "$titulo" -dmenu -bw 0 -lines 3 -separator-style none -location 0 -width $(($l-15)) -hide-scrollbar -padding 5)
	    	if [ "$confirma" == "Sim" ]; then
	    		dbus-launch notify-send -i $iconeOK "WebSite Sync" "Site <b>$site</b> atualizado."
	    	else
	    		dbus-launch notify-send -i $iconeERRO "WebSite Sync" "Atualização de <b>$site</b> cancelada."
	    	fi
		done <<< "$config"
	fi
fi

echo ""