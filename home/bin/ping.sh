#!/usr/bin/env bash
#
# Arquivo: alarme.sh
#
# Feito por Lucas Saliés Brum a.k.a. sistematico, <lucas@archlinux.com.br>
#
# Criado em: 16-03-2018 16:35:20
# Última alteração: 13-01-2019 16:58:17

# Pacotes necessários: sound-theme-freedesktop & libcanberra

icone="${HOME}/.local/share/icons/elementary/preferences-system-network.png"
# /usr/share/sounds/freedesktop/stereo/
online="phone-incoming-call"
offline="phone-outgoing-busy"

host=${1:-"8.8.8.8"}			# Host
tentativas=1					# Tentativas
repeticao=1						# Loop infinito

function pingar {
	ping -q -c$tentativas $host > /dev/null 2> /dev/null
	if [ $? -eq 0 ]; then
		# Polybar
		# if [ "$1" == "-v" ]; then
		# 	echo "%{F#8fbcbb}%{F-}"
		# fi
		if [ ! -f /tmp/online.lock ]; then
			export DISPLAY=:0 ; canberra-gtk-play -i $online 2>&1
			dbus-launch notify-send -i $icone "Ping" "A máquina <b>$(hostname)</b> está online."
			touch /tmp/online.lock
		fi
		break
	else
		# Polybar
		# if [ "$1" == "-v" ]; then
		# 	echo "%{F#bf616a}%{F-}"
		# fi
		export DISPLAY=:0 ; canberra-gtk-play -i $offline 2>&1
		dbus-launch notify-send -i $icone "Ping" "A máquina <b>$(hostname)</b> está offline."
		[ -f /tmp/online.lock ] && rm /tmp/online.lock
	fi
}

if [ $repeticao = 1 ]; then
	while true; do
		pingar
		sleep 3
	done
else
	pingar
fi

# if [ $(ping -q -c3 google.com > /dev/null 2> /dev/null) ]; then
# 	echo "Conexão: OK"
# else
# 	echo "Conexão: FALHOU"
# fi