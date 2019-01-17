#!/bin/bash

pid="$$"
processo=$(pgrep -fla ping.sh | awk '{print $3; exit}')

[ -n "$procsso" ] && echo $$