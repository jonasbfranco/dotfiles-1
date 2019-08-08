#!/usr/bin/env bash
#
# Arquivo: videodown.sh
#
# Feito por Lucas Saliés Brum a.k.a. sistematico, <lucas@archlinux.com.br>
#
# Criado em: 30/04/2019 13:55:09
# Última alteração: 07/08/2019 16:24:14

#xclip -out -selection primary | xclip -in -selection clipboard

log=0 # 0 = Sem log, 1 = Log no arquivo erro.log
aria=1
ts=$(date +"%s")
#dir="${HOME}/desk"
dir="${HOME}/desk/$(ls -t -1 ${HOME}/desk | head -1)"
url="$(xclip -o)"
icone="${HOME}/.local/share/icons/elementary/video-display.png"
som='complete'
erro='complete'
dir="${HOME}/desk"
tmp="/tmp/videodown/$$"
logs="${dir}/status.log"
procFile="/tmp/videodown.pid"

if [ -f $procFile ]; then
    proc=$(cat $procFile)
    echo $((proc+1)) > $procFile
else
    echo 1 > $procFile
    proc=1
fi

if [ ! -d $dir ]; then
	dir="${HOME}/desk"
	if [ ! -d $dir ]; then
		mkdir -p $dir
	fi
fi

if [ ! -d $tmp ]; then
    mkdir -p $tmp
fi

cd $tmp

[ $1 ] && url="$1"

padrao='(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'
if [[ ! ${url} =~ $padrao ]]; then
	notify-send -i $icone "Video Downloader" "O link é inválido!"
    exit
else
	titulo="$(curl "$url" -so - | grep -iPo '(?<=<title>)(.*)(?=</title>)' | iconv -f utf8 -t ascii//TRANSLIT | sed 's/[^[:alnum:]]\+/ /g')"
fi

if [[ $log -ne 0 ]]; then
    echo "---------------------------------------------------------------" >> "$logs"
    echo "Status:       INICIO" >> "$logs"
    echo "Título:       $titulo" >> "$logs"
    echo "URL:          $url" >>"$logs"
    echo "Path:         $dir" >> "$logs"
    echo "Temp:         $tmp" >> "$logs"
    echo "Processos:    $proc" >> "$logs"
fi

notify-send -i $icone "Video Downloader" "Transferencia de: \n\n<b>$titulo</b> iniciada\n\nInstâncias: $proc"

if [ $aria == 1 ]; then
    # -j, --max-concurrent-downloads
    # -x, --max-connection-per-server
    # -m, --max-tries
    # -k, --min-split-size
    # -s, --split restricted by --max-connection-per-server
    # -t, --timeout

    youtube-dl $opts -o "${titulo}.%(ext)s" --external-downloader aria2c --external-downloader-args '-m 20 -c -j 1 -x 5 -s 5 -k 3M' "${url}"
    status="$?"
else
    youtube-dl $opts -o "${titulo}.%(ext)s" "${url}"
    status="$?"
fi

if [[ $status -ne 0 ]]; then
    echo "---------------------------------------------------------------" >> "$logs"
    echo "Status:       ERRO" >> "$logs"
    echo "Título:       $titulo" >> "$logs"
    echo "URL:          $url" >> "$logs"
    echo "Path:         $dir" >> "$logs"
    echo "Temp:         $tmp" >> "$logs"
    echo "Processos:    $proc" >> "$logs"    
    echo "Código:       $status" >> "$logs"
    notify-send -i $icone "Video Downloader" "Erro na transferencia de:\n\n<b>${titulo}*</b>.\n\nInstâncias: $proc"
    canberra-gtk-play -i $erro
fi

if [[ $status -eq 0 ]]; then
    if [[ $log -ne 0 ]]; then
        echo "---------------------------------------------------------------" >> "$logs"
        echo "Status:       SUCESSO" >> "$logs"
        echo "Título:       $titulo" >> "$logs"
        echo "URL:          $url" >> "$logs"
        echo "Path:         $dir" >> "$logs"
        echo "Temp:         $tmp" >> "$logs"
        echo "Processos:    $proc" >> "$logs"
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

    if ls "${titulo}"* 1> /dev/null 2>&1; then
        if ls "${dir}/${titulo}"* 1> /dev/null 2>&1; then
            notify-send -i $icone "Video Downloader" "Já existe um arquivo:\n\n<b>$titulo</b>\n\nEm:\n\n$dir\n\nInstâncias: $proc"
            canberra-gtk-play -i $som
        else
            notify-send -i $icone "Video Downloader" "Sucesso, vídeo salvo:\n\n<b>$titulo</b>\n\nEm:\n\n$dir\n\nInstâncias: $proc"
            mv "${titulo}"* "$dir"
            cd $dir && rm -rf $tmp
        fi
    else
        notify-send -i $icone "Video Downloader" "Erro na transferencia de:\n\n<b>${tmp}/${titulo}*</b>.\n\nInstâncias: $proc"
        canberra-gtk-play -i $erro
    fi
else
    notify-send -i $icone "Video Downloader" "Erro na transferencia de:\n\n<b>$titulo</b>\n\nInstâncias: $proc"
    canberra-gtk-play -i $erro
fi

if [[ -f $procFile ]]; then
    proc=$(cat $procFile)
else
    proc=1
fi

if [[ $proc -lt 2 ]]; then
    rm -f $procFile
else
    echo $((proc-1)) > $procFile
fi
