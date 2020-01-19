#!/usr/bin/env bash

icon="${HOME}/.local/share/icons/panel/batt"

if ! sudo /usr/local/bin/headsetcontrol -b 2> /dev/null | grep -q Battery; then
	echo "<img>${icon}/full.png</img>"
	exit
fi

batt=$(sudo /usr/local/bin/headsetcontrol -b | grep Battery | awk '{print $2}')
batt=${batt%?}

if [ "$batt" == "Chargin" ]; then
	echo "<img>${icon}/charging.png</img>"
elif [ "$batt" -ge 90 ]; then
    echo "<img>${icon}/100.png</img>"
elif [ "$batt" -ge 75 ]; then
    echo "<img>${icon}/75.png</img>"
elif [ "$batt" -ge 50 ]; then
    echo "<img>${icon}/50.png</img>"
elif [ "$batt" -ge 10 ]; then
    echo "<img>${icon}/25.png</img>"
elif [ "$batt" -ge 5 ]; then
    echo "<img>${icon}/5.png</img>"
else
    echo "<img>${icon}/full.png</img>"
fi
