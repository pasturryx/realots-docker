# RealOTS files dockerized

This repository contains Dockerfiles and scripts to build and run RealOTS server **locally**.

This guide is for advanced users who are at least familiar what Docker is and how to use it.

*Although it is possible to expose the server to the internet, it is not recommended due to security reasons mainly due to login server and query manager not being secured properly.*

## Tested

Script was tested on:

1. ArchLinux
2. Windows 11 with WSL2 & Docker integration

## Prerequisites

- Docker
- Docker Compose
- Python 3 for running the scripts

You need to obtain RealOTS server files from OtLand.
When you got the files, you need to place them in the `game` directory.

It is also recommended to have a realots-schema-inc-players.sql file so you can import it to the database.

You need to have following structure:

**It is important to unpack the dennis-libraries.rar file.**

realots-schema-inc-players.sql

```sh
realots-dockerized on master > tree .
.
├── Dockerfile.game
├── Dockerfile.login-server
├── Dockerfile.query-manager
├── README.md
├── docker-compose.yml
├── game
│   ├── dennis-libraries
│   │   ├── ilovesatan.so.9
│   │   ├── libc.so.6
│   │   ├── lmao.so.9
│   │   ├── payhunted.so.9
│   │   ├── rofl.so.9
│   │   ├── satanism.so.9
│   │   ├── test_libpthread.so
│   │   └── trololol.so.9
│   ├── dennis-libraries.rar
│   ├── game
│   └── tibia-game.tarball.tar.gz
├── levels.csv
├── load_db.sh
├── realots-schema-inc-players.sql
├── run.sh
├── scripts
│   ├── ip_changer
│   └── update_levels.py
└── sqls
    ├── insert_users.sql
    ├── update_player_users.sql
    └── update_players.sql

4 directories, 26 files
```

Once that is done you can proceed with building the images.

## Run

To run the server, you need to execute the following command:

```sh
./run.sh
```

This will build the images, load database dumps and start the containers.

## Preparing the client

To connect to the server you also need to modify the client.

In order to that download original 7.70 Tibia client and run following script:

```sh
./scripts/ip_changer path_to_your_tibia.exe 127.0.0.1
```

Or modify the executable by yourself using Hex editor.

# Login into the game

Run your patched Tibia client and log using login/passwd:

100/100 ... 499/499.

## Cleanup the db

Optionally you can clean up the db by invoking following queries on it.

```sh
export MYSQL_USER=otserv
export MYSQL_PASSWORD=otserv
export MYSQL_DATABASE=otserv

# This will set proper player levels in the db
cat sqls/update_players.sql | docker-compose exec -T mysql sh -c 'mysql -u$MYSQL_USER -p"$MYSQL_PASSWORD" "$MYSQL_DATABASE"'
# This will remove players with levels 1, (3..27) (We want to keep GameMasters with level 2)
cat sqls/remove_noobs.sql | docker-compose exec -T mysql sh -c 'mysql -u$MYSQL_USER -p"$MYSQL_PASSWORD" "$MYSQL_DATABASE"'
# This will create new accounts for given levels
cat sqls/insert_users.sql | docker-compose exec -T mysql sh -c 'mysql -u$MYSQL_USER -p"$MYSQL_PASSWORD" "$MYSQL_DATABASE"'
# This will attach players to accounts
cat sqls/update_player_users.sql | docker-compose exec -T mysql sh -c 'mysql -u$MYSQL_USER -p"$MYSQL_PASSWORD" "$MYSQL_DATABASE"'
```

When the db is cleaned up you can log to certain characters with login/passwd combination like this:

11181/11181 and you'll see characters with level 81, 11195/11195 and you'll see characters with level 95 etc etc.

## Scripts

`scripts/` directory contains helpful scripts.

- `ip_changer` uses python and modifies ip that Tibia executable connects to.
- `update_levels.py` was used to read levels.csv and create `update_players.sql` file.

## TODO

- [] Move mysql env variables to env file that could be read by compose/scripts.
- [] Add an option to run with clean db.
- [] Add more scripts.

## Credits

I'd like to give credits to [Crevasse](https://otland.net/threads/tutorial-for-running-7-7-cipsoft-server-on-ubuntu.274678/) and [SilverFern](https://otland.net/threads/script-and-tutorial-to-automate-install-of-leaked-7-70-server.284492/) and all the people from OtLand who released this to the public, patched the binary and created required libs.