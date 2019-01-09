#!/usr/bin/env bash
#
# Arquivo: list.sh
#
# Cria uma lista.txt em /tmp
# Baixa todos os links contidos nesta lista usando o youtube-dl
# Apaga essa lista
#
# Feito por Lucas Saliés Brum a.k.a. sistematico, <lucas@archlinux.com.br>
#
# Criado em: 08/01/2019 21:15:36
# Última alteração: 08/01/2019 21:15:41

[ -f ${HOME}/.config/user-dirs.dirs ] && . ${HOME}/.config/user-dirs.dirs

tipo="video"
icone="${HOME}/.local/share/icons/elementary/preferences-system-network.png"
pasta="${XDG_DESKTOP_DIR:-${HOME}/desk}" 	# Diretório para salvar os arquivos.
lixeira="${HOME}/.local/share/Trash"
url="$(xclip -o)"
som="complete" # /usr/share/sounds/freedesktop/stereo/
#lista="/tmp/lista.txt"
readarray lista < /tmp/lista.txt

[ ! -d $pasta ] && mkdir -p $pasta

if [ "$1" == "-a" ]; then
	[[ ! -z "$url" ]] && echo $url >> $lista
	DISPLAY=:0 canberra-gtk-play -i $som 2>&1
	dbus-launch notify-send -i $icone "Batch Downloader" "Transfêrencias de $url adicionada a $lista"
elif [ "$1" == "-d" ]; then
	[ -f $lista ] && rm $lista
	DISPLAY=:0 canberra-gtk-play -i 'trash-empty' 2>&1
	dbus-launch notify-send -i $icone "Batch Downloader" "/tmp/lista.txt apagada."
elif [ "$1" == "-x" ]; then
	for i in "${lista[@]}"; do
		[ "$2" == "-a" ] && youtube-dl --extract-audio --audio-format mp3 $i || youtube-dl $i
		mv $i $pasta/
		DISPLAY=:0 canberra-gtk-play -i $som 2>&1
		dbus-launch notify-send -i $icone "Batch Downloader" "Transfêrencias de $i finalizada."
	done
fi
