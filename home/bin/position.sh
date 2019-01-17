#!/usr/bin/env bash
#
# Arquivo: alarme.sh
#
# Feito por Lucas Saliés Brum a.k.a. sistematico, <lucas@archlinux.com.br>
#
# Criado em: 16-03-2018 16:35:20
# Última alteração: 17/01/2019 02:50:37

IFS='x' read larguraTela alturaTela < <(xdpyinfo | grep dimensions | grep -o '[0-9x]*' | head -n1)

largura=$(xdotool getactivewindow getwindowgeometry --shell | head -4 | tail -1 | sed 's/[^0-9]*//')
altura=$(xdotool getactivewindow getwindowgeometry --shell | head -5 | tail -1 | sed 's/[^0-9]*//')

centroX=$((larguraTela/2-largura/2))
centroY=$((alturaTela/2-altura/2))

top=0
bottom=$((alturaTela+altura/2))
left=0
right=$((larguraTela-673))

notify-send "$right $bottom"

if [ "$1" == "-tl" ]; then
	xdotool getactivewindow windowmove "$right" "$left"
elif [ "$1" == "-tr" ]; then
	xdotool getactivewindow windowmove "$top" "$right"
elif [ "$1" == "-bl" ]; then
	xdotool getactivewindow windowmove "$bottom" "$left"
elif [ "$1" == "-br" ]; then
	xdotool getactivewindow windowmove "$bottom" "$right"
else
	xdotool getactivewindow windowmove "$centroX" "$centroY"
fi
