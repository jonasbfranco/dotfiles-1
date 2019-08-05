#!/usr/bin/env bash

if [ $(systemctl is-active --quiet $1) == 0 ]; then
    echo OK
fi
