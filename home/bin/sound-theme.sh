#!/usr/bin/env bash

command -v yad 1> /dev/null 2> /dev/null
if [ $? = 1 ]; then
    echo "yad não instalado."
    exit
fi

temas=($(ls /usr/share/sounds))

tema=$(yad --width 300 --entry --title "Tema de Som" \
    #--image=gnome-shutdown                        \
    --image=gtk-play                    \
    --button="gtk-ok:0" --button="gtk-close:1"    \
    --text "Choose action:"                       \
    --entry-text                                  \
    $(ls /usr/share/sounds))

if [ $tema ]; then
	#xfconf-query -c xsettings -p /Net/SoundThemeName -s Yaru
	echo $tema
fi
