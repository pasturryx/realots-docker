#!/usr/bin/env bash
set -e

docker-compose up -d mysql
./load_db.sh

docker-compose up -d login query-manager game
