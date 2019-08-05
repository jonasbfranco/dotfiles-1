#!/usr/bin/env bash

if [ $1 ]; then
    if systemctl is-active --quiet $1; then
        if [ $2 ]; then
            systemctl stop $1
        fi
        echo "$1 ativo"
    else
        if [ $2 ]; then
            systemctl start $1
        fi
        echo "$1 parado"
    fi
fi
