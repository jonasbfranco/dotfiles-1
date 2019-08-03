#!/bin/bash

downloads=$(ps -A | grep youtube-dl | wc -l)

if [ $downloads -gt 0 ]; then
	echo "%{F#BF616A}%{F-} $downloads"
else
	echo ""
fi
