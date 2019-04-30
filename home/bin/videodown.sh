#!/usr/bin/env bash
#
# Arquivo: videodown.sh
#
# Feito por Lucas Saliés Brum a.k.a. sistematico, <lucas@archlinux.com.br>
#
# Criado em: 30/04/2019 13:55:09
# Última alteração: 30/04/2019 13:55:13

aria=1
old="$(pwd)"
pasta="${HOME}/desk"
turl="$(xclip -o)"
icone="${HOME}/.local/share/icons/elementary/camera-photo.png"
som='complete'

opts='-q --restrict-filenames'

[ ! -f $pasta ] && mkdir -p $pasta

cd $pasta

if [ $aria == 1 ]; then
    youtube-dl $opts -o '%(title)s.%(ext)s' --external-downloader aria2c --external-downloader-args '-c -j 1 -x 1 -s 3 -k 1M' "${turl}"
else
    youtube-dl $opts -o '%(title)s.%(ext)s' "${turl}"
fi

rm *.aria2 *.ytdl

notify-send -i $icone "Video Downloader" "Transferencia finalizada."
canberra-gtk-play -i $som

cd $old

exit
