#!/usr/bin/env bash

ativo=$(systemctl is-active --quiet $1)

if [[ $ativo == 0 ]]; then
    echo OK
fi
