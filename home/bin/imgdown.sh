#!/usr/bin/env bash
#
# Arquivo: imgdown.sh
#
# Feito por Lucas Saliés Brum a.k.a. sistematico, <lucas@archlinux.com.br>
#
# Criado em: 16-03-2018 16:35:20
# Última alteração: 08/01/2019 21:15:57
#
# https://gist.github.com/tayfie/6dad43f1a452440fba7ea1c06d1b603a

ext="jpg"  		# Separadas por virgula.
pasta="$(pwd)" 	# Diretório para salvar os arquivos.
min='300' 		# Em pixels verticais
lixeira="${HOME}/.local/share/Trash"
pasta="${HOME}/desk/$$"
turl="$(xclip -o)"
icone="${HOME}/.local/share/icons/elementary/camera-photo.png"
# /usr/share/sounds/freedesktop/stereo/
som='complete'

if [ ! -f $pasta ]; then
	mkdir -p $pasta
else
	exit
fi

dominio=$(echo "$turl" | sed -e "s/[^/]*\/\/\([^@]*@\)\?\([^:/]*\).*/\2/" | sed "s/^www\.//")
wget --quiet -P "$pasta" -nd -r -l 1 -H -D $dominio -A $ext "$turl"

for a in $pasta/*.$ext; do
	if [[ $(convert $a -print "%h" /dev/null) -lt $min ]]; then
		mv $a $lixeira
	fi
done

rm -rf $pasta/robots.txt*

notify-send -i $icone "IMGdown" "Transferencia $$ finalizada."
canberra-gtk-play -i $som
