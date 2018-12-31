#!/usr/bin/env sh

# B & W
conf="${HOME}/.config/polybar/config"
if grep -q "Tema Branco" "$conf"; then
    cat ${HOME}/.config/polybar/preto > ${HOME}/.config/polybar/config
else
	cat ${HOME}/.config/polybar/branco > ${HOME}/.config/polybar/config
fi
cat ${HOME}/.config/polybar/principal >> ${HOME}/.config/polybar/config


# Terminate already running bar instances
killall -q polybar 

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

polybar -q top &
polybar -q bottom &
