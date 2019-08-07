#!/bin/bash

downloads=$(ps -A | grep youtube-dl | wc -l)

if [ $1 ]; then

	$HOME/bin/videodown.sh
	echo "%{F#D08770}%{F-} $downloads"

else


	if [ $downloads -gt 0 ]; then
		echo "%{F#D08770}%{F-} $downloads"
	else
		echo "%{F#D08770}%{F-}"
	fi
fi
