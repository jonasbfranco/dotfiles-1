#!/usr/bin/env bash

if [ "$1" == "c" ]; then
	killall youtube-dl
elif [ "$1" == "x" ]; then
	bash -c "$HOME/bin/videodown.sh"
elif [ "$1" == "i" ]; then
	bash -c "$HOME/bin/imgdown.sh"
else 
	videos=$(ps -A | grep youtube-dl | wc -l)
	imagens=$(ps -ef | grep imgdown.sh | grep -v grep | wc -l)
	echo "%{F#D08770}%{F-} $videos / $imagens"
fi