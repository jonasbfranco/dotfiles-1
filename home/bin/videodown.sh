#!/usr/bin/env bash
#
# Arquivo: videodown.sh
#
# Feito por Lucas Saliés Brum a.k.a. sistematico, <lucas@archlinux.com.br>
#
# Criado em: 30/04/2019 13:55:09
# Última alteração: 01/05/2019 14:32:25

aria=1
ts=$(date +"%s")
dir="${HOME}/desk"
url="$(xclip -o)"
icone="${HOME}/.local/share/icons/elementary/video-display.png"
som='complete'
#opts='-q'

[ ! -f $dir ] && mkdir -p $dir
[ $1 ] && url="$1"

padrao='(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'
if [[ ! ${url} =~ $padrao ]]; then
	notify-send -i $icone "Video Downloader" "O link $url é inválido!"
    exit
else
	titulo=$(curl "$url" -so - | grep -iPo '(?<=<title>)(.*)(?=</title>)' | iconv -f utf8 -t ascii//TRANSLIT | sed 's/[^[:alnum:]]\+/ /g')
fi

cd $dir

if [ $aria == 1 ]; then
    youtube-dl $opts -o "${titulo}.%(ext)s" --external-downloader aria2c --external-downloader-args '-m 10 -c -j 1 -x 3 -s 3 -k 2M' "${url}"
else
    youtube-dl $opts -o "${titulo}.%(ext)s" "${url}"
fi

if [ "$?" -ne "0" ]; then
    erro="$?"
    echo "------------------------------------" >> erro.log
    echo "Erro no download" >> erro.log
    echo "Título: $titulo" >> erro.log
    echo "URL:    $url" >> erro.log
    echo "Código: $erro" >> erro.log
    exit
fi

arquivos=$(ls "${titulo}"* | egrep -vi '.mp4|.avi|.mkv|.log')
for i in "${arquivos[@]}"
do
    if [ -f "$i" ]; then
        mod=$(stat -c "%Y" "$i")
        if [[ $mod > $ts ]]; then
            rm -f "$i"
        fi
    fi
done

notify-send -i $icone "Video Downloader" "Transferencia de <b>$titulo</b> finalizada."
canberra-gtk-play -i $som
