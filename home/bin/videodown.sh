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

aria=1
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
if [ $aria == 1 ]; then
    youtube-dl -q -o -o '%(title)s.%(ext)s' --external-downloader aria2c --external-downloader-args '-c -j 3 -x 3 -s 3 -k 1M' "$turl"
else
    youtube-dl -q -o '%(title)s.%(ext)s' "$turl"
fi

notify-send -i $icone "Video Downloader" "Transferencia $$ finalizada."
canberra-gtk-play -i $som
cd $old

exit
