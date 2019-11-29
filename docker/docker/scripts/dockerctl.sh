#!/usr/bin/env bash
# 
# dockerctl.sh
#
# Criado em: 28-11-2019 23:50:39
# Alterado em: 28-11-2019 23:50:45

if [ "$1" == "stop" ]; then
	docker ps -q | xargs docker stop
fi

if [ "$1" == "start" ]; then
	docker ps -a -q | xargs docker start
fi

if [ "$1" == "rm" ]; then
    docker ps -q | xargs docker stop
    docker ps -a -q | xargs docker rmi -v
fi

if [ "$1" == "rmi" ]; then
    docker ps -q | xargs docker stop
    docker ps -a -q | xargs docker rmi -v
    docker images -q | xargs docker rmi -v
fi

if [ "$1" == "upgrade" ]; then
    docker ps -a -q | xargs docker stop
    docker images | grep -v REPOSITORY | awk '{print $1}' | xargs -L1 docker pull 
    docker ps -a -q | xargs docker start
fi