#!/usr/bin/env bash

if [ $2 ]; then
    [ "$1" == "-u" ] && param="--user"

    if systemctl $param is-active --quiet $2; then
        if [ $3 ]; then
            systemctl $param stop $2
            echo "$2 parado"
        else
            echo "$2 ativo"
        fi
    else
        if [ $3 ]; then
            systemctl $param start $2
            echo "$2 ativo"
        else
            echo "$2 parado"
        fi
    fi
fi
