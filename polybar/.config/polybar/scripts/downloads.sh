#!/usr/bin/env bash

downloads=$(ps -A | grep youtube-dl | wc -l)
if [ $downloads -gt 0 ]; then
	echo "%{F#D08770}%{F-} $downloads"
else
	echo "%{F#D08770}%{F-}"
fi

if [ "$1" == "c" ]; then
	killall youtube-dl
elif [ "$1" == "x" ]; then
	#bash -c "$HOME/bin/videodown.sh" &
	$(which bash) -c "$HOME/bin/videodown.sh" &
fi

exit