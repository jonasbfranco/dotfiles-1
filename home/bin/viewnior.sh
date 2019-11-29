#!/usr/bin/env bash
#
# Arquivo: viewnior.sh
#
# Feito por Lucas Saliés Brum a.k.a. sistematico, <lucas@archlinux.com.br>
#
# Criado em: 16/03/2018 16:35:20
# Última alteração: 29-11-2019 14:50:28

shopt -s globstar dotglob nocaseglob

if [ $1 ]; then
    DISPLAY=:0 viewnior $1/**/*.jpg
else
    DISPLAY=:0 viewnior **/*.jpg
fi
