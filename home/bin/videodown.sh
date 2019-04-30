#!/usr/bin/env bash
#
# Arquivo: videodown.sh
#
# Feito por Lucas Saliés Brum a.k.a. sistematico, <lucas@archlinux.com.br>
#
# Criado em: 16-03-2018 16:35:20
# Última alteração: 08/01/2019 21:15:57
#
# https://gist.github.com/tayfie/6dad43f1a452440fba7ea1c06d1b603a

old="$(pwd)"
pasta="${HOME}/desk/$$"
turl="$(xclip -o)"
icone="${HOME}/.local/share/icons/elementary/camera-photo.png"
som='complete'

if [ ! -f $pasta ]; then
	mkdir -p $pasta
else
	exit
fi

cd $pasta
youtube-dl -q -o '%(title)s.%(ext)s' "$turl"
notify-send -i $icone "Video Downloader" "Transferencia $$ finalizada."
canberra-gtk-play -i $som
cd $old

exit
