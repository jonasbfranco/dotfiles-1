#!/usr/bin/env bash

url="https://hblock.molinero.dev/hosts"
curl -s -L "$url" > hblock.tmp

if md5sum -c hblock.md5; then
	rm hblock.tpm
else
    mv hblock.md5 02-hblock.conf
    [ -f /etc/hosts ] && mv /etc/hosts /etc/hosts.d/hosts.bkp.$(date +'%s')
    cat /etc/hosts.d/*.conf > /etc/hosts
	md5sum 02-hblock.conf > hblock.md5
fi
