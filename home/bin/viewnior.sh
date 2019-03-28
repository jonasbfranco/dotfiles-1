#!/usr/bin/env bash
#
# Arquivo: viewnior.sh
#
# Feito por Lucas Saliés Brum a.k.a. sistematico, <lucas@archlinux.com.br>
#
# Criado em: 16/03/2018 16:35:20
# Última alteração: 28/03/2019 06:02:03

[ $1 ] && oldpwd="$(pwd)" && cd "$1"
DISPLAY=:0.0 ; viewnior $(find . -iname '*.jpg')
[ $1 ] && cd "$oldpwd"
