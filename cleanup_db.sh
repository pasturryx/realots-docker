#!/usr/bin/env bash

export MYSQL_USER=otserv
export MYSQL_PASSWORD=otserv
export MYSQL_DATABASE=otserv

cat sqls/update_players.sql | docker-compose exec -T mysql sh -c 'mysql -u$MYSQL_USER -p"$MYSQL_PASSWORD" "$MYSQL_DATABASE"'
cat sqls/remove_noobs.sql | docker-compose exec -T mysql sh -c 'mysql -u$MYSQL_USER -p"$MYSQL_PASSWORD" "$MYSQL_DATABASE"'
cat sqls/insert_users.sql | docker-compose exec -T mysql sh -c 'mysql -u$MYSQL_USER -p"$MYSQL_PASSWORD" "$MYSQL_DATABASE"'
cat sqls/update_player_users.sql | docker-compose exec -T mysql sh -c 'mysql -u$MYSQL_USER -p"$MYSQL_PASSWORD" "$MYSQL_DATABASE"'