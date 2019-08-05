#!/usr/bin/env bash

if [[ $(systemctl is-active --quiet $1) -eq 0 ]]; then
    echo OK
fi
