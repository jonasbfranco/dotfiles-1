#!/bin/sh

if pgrep -x "xautolock" > /dev/null
then
	[ $1 ] && killall xautolock && notify-send -i ~/.local/share/icons/elementary/screensaver.png "Screen Locker" "Proteção de tela desativada." &
	echo "%{F#D08770}%{F-}"
else
	[ $1 ] && xautolock -time 3 -detectsleep -locker $HOME/.local/lock/fortune && notify-send -i ~/.local/share/icons/elementary/screensaver.png "Screen Locker" "Proteção de tela ativada." &
	echo ""
fi
