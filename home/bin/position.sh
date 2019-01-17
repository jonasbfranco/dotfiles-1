#!/usr/bin/env bash
#
# Arquivo: alarme.sh
#
# Feito por Lucas Saliés Brum a.k.a. sistematico, <lucas@archlinux.com.br>
#
# Criado em: 16-03-2018 16:35:20
# Última alteração: 17/01/2019 02:50:37

IFS='x' read screenWidth screenHeight < <(xdpyinfo | grep dimensions | grep -o '[0-9x]*' | head -n1)

width=$(xdotool getactivewindow getwindowgeometry --shell | head -4 | tail -1 | sed 's/[^0-9]*//')
height=$(xdotool getactivewindow getwindowgeometry --shell | head -5 | tail -1 | sed 's/[^0-9]*//')

centerX=$((screenWidth/2-width/2))
centerY=$((screenHeight/2-height/2))

top=0
bottom=$((screenHeight-height))
left=0
right=$((screenWidth-width))

if [ "$1" == "-tl" ]; then
	xdotool getactivewindow windowmove "$top" "$left"
elif [ "$1" == "-tr" ]; then
	xdotool getactivewindow windowmove "$top" "$right"
elif [ "$1" == "-bl" ]; then
	xdotool getactivewindow windowmove "$bottom" "$left"
elif [ "$1" == "-br" ]; then
	xdotool getactivewindow windowmove "$bottom" "$right"
else
	xdotool getactivewindow windowmove "$centerX" "$centerY"
fi
