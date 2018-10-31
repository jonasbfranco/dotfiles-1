#!/usr/bin/env bash

gradientes=(
	'#bdc3c7 #2c3e50'
	'#0F2027 #2C5364'
	'#373B44 #4286f4'
)

gradiente=${gradientes[$RANDOM % ${#gradientes[@]}]}
primeiro=$(echo $gradiente | awk '{print $1;}')
segundo=$(echo $gradiente | awk '{print $NF}')

hsetroot -add "$primeiro" -add "$segundo" -gradient 0