#!/bin/bash

processo=$(ps x | egrep -v grep | grep toolbox.sh | awk '{print $1}')

[ -n "$processo" ] && echo $$