#!/usr/bin/env bash

if [ $(systemctl is-running $1) ]; then
    echo OK
fi
