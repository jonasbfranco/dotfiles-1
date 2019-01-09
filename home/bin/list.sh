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
pasta="${XDG_DESKTOP_DIR:-${HOME}/desk}" 	# Diretório para salvar os arquivos.
[ ! -d $pasta ] && mkdir -p $pasta
lixeira="${HOME}/.local/share/Trash"
url="$(xclip -o)"
icone='/usr/share/icons/Arc/places/24@2x/folder-pictures.png'
# /usr/share/sounds/freedesktop/stereo/
som="complete"
lista="/tmp/lista.txt"

if [ "$1" == "-a" ]; then
	[[ ! -z "$url" ]] && echo $url >> $lista
elif [ "$1" == "-d" ]; then
	[ -f $lista ] && rm $lista
elif [ "$1" == "-x" ]; then
	youtube-dl -a $lista
	DISPLAY=:0 canberra-gtk-play -i $som 2>&1
	dbus-launch notify-send -i $icone "Batch Downloader" "Transfêrencias finalizadas."
fi

