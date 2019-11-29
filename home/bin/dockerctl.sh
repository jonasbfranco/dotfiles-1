#!/usr/bin/env bash

if [ "$1" == "stop" ]; then
	docker ps -q | xargs docker stop
fi

if [ "$1" == "start" ]; then
	docker ps -q | xargs docker stop
fi

if [ "$1" == "rmi" ]; then
    docker images -q | xargs docker rmi -v
fi

if [ "$1" == "upgrade" ]; then
    docker images | grep -v REPOSITORY | awk '{print $1}' | xargs -L1 docker pull 
fi