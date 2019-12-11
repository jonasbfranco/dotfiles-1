#!/usr/bin/env bash

arquivo="$1"
base=$(echo "${arquivo%.*}")
legenda="${base}.srt"
params="--video -i"

[ -f "$legenda" ] && sub="--subtitles $legenda"
[ -f "$arquivo" ] && mkchromecast "$params" "$arquivo" "$sub"
