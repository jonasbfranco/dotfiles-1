#!/usr/bin/env bash
#
# Arquivo: videodown.sh
#
# Feito por Lucas Saliés Brum a.k.a. sistematico, <lucas@archlinux.com.br>
#
# Criado em: 30/04/2019 13:55:09
# Última alteração: 30/04/2019 14:05:56

aria=1
old="$(pwd)"
dir="${HOME}/desk"
url="$(xclip -o)"
icone="${HOME}/.local/share/icons/elementary/video-display.png"
som='complete'

opts='-q --restrict-filenames'

[ ! -f $dir ] && mkdir -p $dir
[ $1 ] && url="$1"

padrao='(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'
if [[ ! ${url} =~ $padrao ]]; then 
	echo "Link inválido."
    exit
else
	titulo=$(curl "$url" -so - | grep -iPo '(?<=<title>)(.*)(?=</title>)')
	#titulo=$(echo "$titulo" | tr -cd '[:alnum:]._-')
	titulo=$(echo $titulo | iconv -f utf8 -t ascii//TRANSLIT)
	#titulo=$(echo "$titulo" | sed -r 's/[xyz]+/_/g')
	#titulo=$(echo "$titulo" | sed -r 's/[xyz]+/_/g')
	titulo=$(echo "$titulo" | sed "s/^[:alnum:]/_/g")
	#echo $titulo | sed "s|$var1|ZZ|g")
fi

echo $titulo

#cd $dir

#if [ $aria == 1 ]; then
#    youtube-dl $opts -o '%(title)s.%(ext)s' --external-downloader aria2c --external-downloader-args '-c -j 1 -x 1 -s 3 -k 1M' "${url}"
#else
#    youtube-dl $opts -o '%(title)s.%(ext)s' "${url}"
#fi

#rm *.aria2 *.ytdl *.part 2> /dev/null

#notify-send -i $icone "Video Downloader" "Transferencia finalizada."
#canberra-gtk-play -i $som

#cd $old