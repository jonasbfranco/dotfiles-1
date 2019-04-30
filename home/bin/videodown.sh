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
pasta="${HOME}/desk"
turl="$(xclip -o)"
icone="${HOME}/.local/share/icons/elementary/camera-photo.png"
som='complete'

# -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best'
# 'bestvideo[height<=480]+bestaudio/best[height<=480]'
# 'best[filesize<50M]'
# '(bestvideo+bestaudio/best)[protocol^=http]'
# 'bestvideo,bestaudio' -o '%(title)s.f%(format_id)s.%(ext)s'

opts='-q --restrict-filenames'

if [ ! -f $pasta ]; then
	mkdir -p $pasta
#else
#	exit
fi

cd $pasta

if [ $aria == 1 ]; then
    youtube-dl $opts -o '%(title)s.%(ext)s' --external-downloader aria2c --external-downloader-args '-c -j 1 -x 2 -s 5 -k 1M' "${turl}"
else
    youtube-dl $opts -o '%(title)s.%(ext)s' "${turl}"
fi

rm *.aria2 *.ytdl

notify-send -i $icone "Video Downloader" "Transferencia finalizada."
canberra-gtk-play -i $som

cd $old

exit