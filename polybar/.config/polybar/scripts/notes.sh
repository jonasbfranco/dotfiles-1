#!/usr/bin/env bash

notes=$(cat ~/.rofi_notes | wc -l)
((notes--))

if [ $notes -gt 0 ]; then
	echo "%{F#D08770}%{F-} $notes"
else
	echo "%{F#D08770}%{F-}"
fi
