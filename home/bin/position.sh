#!/usr/bin/env bash
#
# Arquivo: alarme.sh
#
# Feito por Lucas Saliés Brum a.k.a. sistematico, <lucas@archlinux.com.br>
#
# Criado em: 16-03-2018 16:35:20
# Última alteração: 17/01/2019 02:50:37

barra=59 # Altura da barra do DE/WM

IFS='x' read larguraTela alturaTela < <(xdpyinfo | grep dimensions | grep -o '[0-9x]*' | head -n1)

largura=$(xdotool getactivewindow getwindowgeometry --shell | head -4 | tail -1 | sed 's/[^0-9]*//')
altura=$(xdotool getactivewindow getwindowgeometry --shell | head -5 | tail -1 | sed 's/[^0-9]*//')

centroX=$((larguraTela/2-largura/2))
centroY=$((alturaTela/2-altura/2))

topo=0
baixo=$((alturaTela-altura))
esquerda=0
right=$((larguraTela-largura))

notify-send "$right $baixo"

if [ "$1" == "-tl" ]; then
	xdotool getactivewindow windowmove "$esquerda" "$topo"
elif [ "$1" == "-tr" ]; then
	xdotool getactivewindow windowmove "$right" "$topo"
elif [ "$1" == "-bl" ]; then
	baixo=$((baixo-barra))
	xdotool getactivewindow windowmove "$esquerda" "$baixo"
elif [ "$1" == "-br" ]; then
	baixo=$((baixo-barra))
	xdotool getactivewindow windowmove "$right" "$baixo"
else
	xdotool getactivewindow windowmove "$centroX" "$centroY"
fi
