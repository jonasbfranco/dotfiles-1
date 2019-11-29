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
    read -p "Tem certeza que deseja remover TODOS os containers?" resp
    if [[ "$resp" == [sS]* ]]; then
        if [[ "$(docker ps -q -a)" ]]; then
            docker ps -q | xargs docker stop
            docker ps -a -q | xargs docker rm -v
        fi
    fi
fi

if [ "$1" == "rmi" ]; then
    read -p "Tem certeza que deseja remover TODAS as imagens?" resp
    if [[ "$resp" == [sS]* ]]; then
        docker ps -q | xargs docker stop
        docker ps -a -q | xargs docker rmi -v
        docker images -q | xargs docker rmi
    fi
fi

if [ "$1" == "upgrade" ]; then
    docker ps -a -q | xargs docker stop
    docker images | grep -v REPOSITORY | awk '{print $1}' | xargs -L1 docker pull 
    docker ps -a -q | xargs docker start
fi

if [ "$1" == "rebuild" ]; then
    if [ -f docker-compose.yml ]; then
        docker-compose up -d --build
    else
        echo "Não existe um arquivo docker-compose.yml no diretório atual."
    fi
fi