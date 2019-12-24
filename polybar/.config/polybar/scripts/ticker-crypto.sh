#!/bin/sh

api="https://www.mercadobitcoin.net/api/BTC/ticker/"
quote=$(curl -sf $api | jq -r ".ticker.last")
#quote=$(LANG=C printf "%.2f" "$quote")
#quote=$(LANG=C printf "%.2e" "$quote")
quote=$(LC_NUMERIC="pt_BR.UTF-8" printf "%'.2f" "$quote")

echo " $quote"
