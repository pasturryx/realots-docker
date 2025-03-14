#!/usr/bin/env bash
set -e

echo "Building services..."
docker-compose build login query-manager game

echo "Starting MySQL..."
docker-compose up -d mysql

echo "Loading database..."
./load_db.sh

echo "Starting services..."
docker-compose up -d login query-manager game
echo "All services started!"