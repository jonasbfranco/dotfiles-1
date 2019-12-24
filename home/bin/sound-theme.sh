#!/usr/bin/env bash

command -v yad 1> /dev/null 2> /dev/null
if [ $? = 1 ]; then
    echo "yad não instalado."
    exit
fi

temas=($(ls /usr/share/sounds))

xfconf-query -c xsettings -p /Net/SoundThemeName -s Yaru
