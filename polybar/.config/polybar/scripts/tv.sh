#!/bin/sh

if pgrep -x "xautolock" > /dev/null
then
	[ $1 ] && killall xautolock &
	echo ""
else
	[ $1 ] && xautolock -time 3 -detectsleep -locker $HOME/.local/lock/fortune &
	echo ""
fi
