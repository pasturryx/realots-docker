export MYSQL_USER=otserv
export MYSQL_PASSWORD=otserv
export MYSQL_DATABASE=otserv
cat realots-schema-inc-players.sql | docker-compose exec -T mysql sh -c 'mysql -u$MYSQL_USER -p"$MYSQL_PASSWORD" "$MYSQL_DATABASE"'
