#!/usr/bin/env bash

command -v yad 1> /dev/null 2> /dev/null
if [ $? = 1 ]; then
    echo "yad não instalado."
    exit
fi

tema=$(yad --width 300 --entry --title "Tema de Som" \
    --image=gnome-shutdown                        \
    --button="gtk-ok:0" --button="gtk-close:1"    \
    --text "Choose action:"                       \
    --entry-text                                  \
    $(ls /usr/share/sounds))

if [ $tema ]; then
	if [ -f $HOME/.gtkrc-2.0 ]; then
		sed -i 's/Var2=.*/Var2=smurf/' file.txt
	fi

    if [ -f $HOME/.gtkrc-2.0 ]; then
        sed -i 's/Var2=.*/Var2=smurf/' file.txt
    fi

	xfconf-query -c xsettings -p /Net/SoundThemeName -s $tema
	DISPLAY=:0 canberra-gtk-play -i complete
fi
