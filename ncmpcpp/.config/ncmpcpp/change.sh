#!/usr/bin/env bash

notify-send -i "${HOME}/.local/share/icons/elementary/audio-speakers.png" "$(mpc current)"

bash art.sh