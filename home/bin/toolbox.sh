#!/bin/bash

pid="$$"
processo=$(ps x | egrep -v "$pid" | egrep -v grep | grep toolbox.sh  | awk '{print $1}')

[ -n "$processo" ] && echo $$