#!/bin/bash

if [ -f $HOME/.config/api-keys.sh ]; then
	source $HOME/.config/api-keys.sh
else
	echo "Arquivo de APIs não encontrado."
	exit
fi

api=$(curl -s -H "X-CMC_PRO_API_KEY: ${coinmarketcap}" -H "Accept: application/json" -d "id=1" -G https://pro-api.coinmarketcap.com/v1/cryptocurrency/quotes/latest)
quote=$(curl -sf $api | jq -r ".")
#quote=$(LANG=C printf "%'.4s" ${quote})
#quote=$(LANG=pt_BR.UTF-8 printf "%'.2f" ${quote})
echo " $quote"
