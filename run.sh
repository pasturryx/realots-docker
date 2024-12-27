#!/usr/bin/env bash
set -e

docker-compose build login query-manager game
docker-compose up -d mysql
./load_db.sh

docker-compose up -d login query-manager game
