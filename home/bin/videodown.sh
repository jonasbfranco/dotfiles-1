#!/usr/bin/env bash
#
# Arquivo: videodown.sh
#
# Feito por Lucas Saliés Brum a.k.a. sistematico, <lucas@archlinux.com.br>
#
# Criado em: 30/04/2019 13:55:09
# Última alteração: 01/05/2019 14:32:25

log=1 # 0 = Sem log, 1 = Log na tela, 2 = Log no arquivo erro.log
aria=1
retries=10 # 0 = inf
md=1 # Max Downloads
mc_server=5 # Max conn per server
mc=5 # Max conn
piece="1M" # Slit filesize
ts=$(date +"%s")
dir="${HOME}/desk"
url="$(xclip -o)"
icone="${HOME}/.local/share/icons/elementary/video-display.png"
som='complete'
#opts='-q'
ariaopts="-m $retries -c -j $md -x $mc_server -s $mc -k $piece"

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
    # -j, --max-concurrent-downloads
    # -x, --max-connection-per-server
    # -m, --max-tries
    # -k, --min-split-size
    # -s, --split restricted by --max-connection-per-server 
    # -t, --timeout

    youtube-dl $opts -o "${titulo}.%(ext)s" --external-downloader aria2c --external-downloader-args $ariaopts "${url}" && status=$?
else
    youtube-dl $opts -o "${titulo}.%(ext)s" "${url}" && status=$?
fi

[ "$log" -eq "1" ] && logs=""
[ "$log" -eq "2" ] && logs=">> erro.log"

if [ "$status" -ne "0" ] && [ $log -ne 0 ]; then
    echo "------------------------------------" $logs
    echo "Erro no download" $logs
    echo "Título: $titulo" $logs
    echo "URL:    $url" >> $logs
    echo "Código: $status" >> $logs
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
