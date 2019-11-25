#!/bin/sh

if pgrep -x "xautolock" > /dev/null
then
	[ $1 ] && killall xautolock &
	echo "%{F#D08770}%{F-}"
else
	[ $1 ] && xautolock -time 3 -detectsleep -locker $HOME/.local/lock/fortune && notify-send -i ~/.config/dunst/icons/moon.svg "Screen Locker" "$(python2 ~/.config/polybar/scripts/moonphase.py desc)" &
	echo ""
fi
