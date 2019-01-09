#!/bin/sh

profile="lucas"
success="${HOME}/.local/share/icons/elementary/preferences-system-network.svg"
error="${HOME}/.local/share/icons/elementary/network-error.svg"
secs=5000
dspl="DISPLAY=:0"

if [ "$(netctl is-active ${profile})" == "active" ]; then
	export $dspl && notify-send "Erro" "O perfil <b>${profile}</b> já está ativo." -i $error -t $secs
elif [ "$(netctl is-active $profile)" == "inactive" ]; then
	export $dspl && notify-send "Sucesso" "O perfil <b>${profile}</b> não está ativo.\n\nConectando..." -i $success -t $secs
	sudo netctl start $profile
elif [ "$(netctl is-active $profile)" == "failed" ]; then
	export $dspl && notify-send "Erro" "O perfil <b>${profile}</b> falhou, tentando novamente." -i $error -t $secs
	sudo netctl stop-all
	sleep 5
	sudo netctl start $profile
else
	export $dspl && notify-send "Erro" "Um erro inesperado aconteceu." -i $error -t $secs
fi

