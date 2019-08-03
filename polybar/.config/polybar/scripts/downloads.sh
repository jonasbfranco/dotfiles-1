#!/bin/bash

downloads=$(ps -A | grep youtube-dl | wc -l)

if [ $downloads -gt 0 ]; then
	echo " $downloads"
else
	echo ""
fi
