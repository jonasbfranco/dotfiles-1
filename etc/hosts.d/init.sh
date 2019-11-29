#!/usr/bin/env bash

[ "$EUID" -ne 0 ] && echo "É necessário rodar o script como root." && exit 1

url="https://hblock.molinero.dev/hosts"
curl -s -L "$url" > hblock.tmp
sed -i '0,/^# <\/header>$/d' hblock.tmp

if md5sum -c hblock.md5 > /dev/null; then
	rm hblock.tmp
else
    mv hblock.md5 02-hblock.conf
    [ -f /etc/hosts ] && mv /etc/hosts /etc/hosts.d/hosts.bkp.$(date +'%s')
    cat /etc/hosts.d/*.conf > /etc/hosts
	md5sum 02-hblock.conf > hblock.md5
fi
