# RealOTS files dockerized

This repository contains Dockerfiles and scripts to build and run RealOTS server **locally**.

This guide is for advanced users who are at least familiar what Docker is and how to use it.

*Although it is possible to expose the server to the internet, it is not recommended due to security reasons mainly due to login server and query manager not being secured properly.*

## Prerequisites

- Docker
- Docker Compose
- Python 3 for running the scripts

You need to obtain RealOTS server files from OtLand.
When you got the files, you need to place them in the `game` directory.

It is also recommended to have a realots-schema-inc-players.sql file so you can import it to the database.

You need to have following structure:

**It is important to unpack the dennis-libraries.rar file.**

```sh
realots-dockerized on master > tree .
.
├── docker-compose.yml
├── Dockerfile.game
├── Dockerfile.login-server
├── Dockerfile.query-manager
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
│   ├── game.i64
│   ├── start-game-server.sh
│   └── tibia-game.tarball.tar.gz
├── gamel
├── insert_users.sql
├── levels.csv
├── load_db.sh
├── oracle
├── README.md
├── realots-schema-inc-players.sql
├── remap.sh
├── run.sh
├── update_levels.py
├── update_players.sql
├── update_player_users.sql
└── wsad_to_arrow.sh

5 directories, 28 files
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
