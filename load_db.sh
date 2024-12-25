export MYSQL_USER=otserv
export MYSQL_PASSWORD=otserv
export MYSQL_DATABASE=otserv

# until docker-compose exec mysql mysqladmin ping -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" --silent; do
#   echo "Waiting for MySQL to be ready..."
#   sleep 2
# done

until docker-compose exec mysql mysql -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "USE $MYSQL_DATABASE"; do
  echo "Waiting for MySQL database to be ready..."
  sleep 2
done

cat realots-schema-inc-players.sql | docker-compose exec -T mysql sh -c 'mysql -u$MYSQL_USER -p"$MYSQL_PASSWORD" "$MYSQL_DATABASE"'
