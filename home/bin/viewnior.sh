#!/usr/bin/env bash
#
# Arquivo: viewnior.sh
#
# Feito por Lucas Saliés Brum a.k.a. sistematico, <lucas@archlinux.com.br>
#
# Criado em: 16/03/2018 16:35:20
# Última alteração: 28/03/2019 06:02:03

if [ "$1" && -d "$1" ]; then
    oldpwd="$(pwd)" && cd "$1"
else
    exit
fi

if [ $2 ]; then
    DISPLAY=:0.0 ; viewnior $(find . -iname "*${2}*.jpg")
else
    DISPLAY=:0.0 ; viewnior $(find . -iname '*.jpg')
fi

[ $1 ] && cd "$oldpwd"
