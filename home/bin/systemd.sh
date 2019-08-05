#!/usr/bin/env bash

if [[ $(systemctl is-active $1) == 0 ]]; then
    echo OK
fi
