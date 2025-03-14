#!/bin/bash
export MYSQL_USER=otserv
export MYSQL_PASSWORD=otserv
export MYSQL_DATABASE=otserv
export MYSQL_HOST=mysql

echo "Waiting for MySQL to be ready..."
until docker-compose exec -T mysql mysqladmin ping -h"$MYSQL_HOST" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" --silent; do
  echo "MySQL is not ready yet... waiting 5 seconds"
  sleep 5
done
echo "MySQL is ready!"

echo "Loading schema..."
cat sqls/realots-schema-inc-players.sql | docker-compose exec -T mysql mysql -h"$MYSQL_HOST" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" "$MYSQL_DATABASE"
echo "Schema loaded successfully!"