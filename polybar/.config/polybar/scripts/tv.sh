#!/bin/sh

if pgrep -x "xautolock" > /dev/null
then
	echo "sim"
else
	echo "não"
fi
