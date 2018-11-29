#!/bin/bash

string="$1"

case $3 in
comentar)
	sed -i "s/^#\($string\)\$/\1/" $2
    ;;
descomentar)
    sed -i "s/^$string\$/#&/" $2
    ;;
esac
