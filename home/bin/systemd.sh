#!/usr/bin/env bash

if [ $(systemctl is-active $1) ]; then
    echo OK
fi
