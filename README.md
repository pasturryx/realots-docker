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

`realots-schema-inc-players.sql` must be put inside `sqls/` directory.

```sh
realots-docker on master ➜ tree .
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
├── run.sh
├── scripts
│   ├── ip_changer
│   └── update_levels
└── sqls
    ├── insert_users.sql
    ├── realots-schema-inc-players.sql
    ├── remove_noobs.sql
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
./cleanup_db.sh
```

When the db is cleaned up you can log to certain characters with login/passwd combination like this:

11181/11181 and you'll see characters with level 81, 11195/11195 and you'll see characters with level 95 etc etc.

## Scripts

`scripts/` directory contains helpful scripts.

- `ip_changer` uses python and modifies ip that Tibia executable connects to.
- `update_levels.py` was used to read levels.csv and create `update_players.sql` file.

## TODO

- [ ] Move mysql env variables to env file that could be read by compose/scripts.
- [ ] Add an option to run with clean db (just schema).
- [ ] Add more scripts (create players, change exp rate etc).
- [ ] Lock certain commits when downloading login server and query manager in respective docker files.
- [ ] Push at least login server and query manager images into the Docker Hub.

## Useful links

- [OTLand thread with RealOTS files](https://otland.net/threads/7-7-realots-7-7-cipsoft-files-virgin.244562/)
- [OTLand How to run a fresh 7.7 Cipsoft Server](https://otland.net/threads/tutorial-how-to-run-a-fresh-7-7-cipsoft-server.284993/)
- [OTLand Script and tutorial to automate install of "Leaked" 7.70 server](https://otland.net/threads/script-and-tutorial-to-automate-install-of-leaked-7-70-server.284492/)
- [github.com/nekiro/dockerized-realots](https://github.com/nekiro/dockerized-realots) - found similar thing after I've done this one so this is imlemented from scratch, not inspired by Nekiro's work. Also that one contains things like setting up phpmyadmin - I'm comfortable with talking to mysql via command line so didn't add this.

## Credits

I'd like to give credits to [Crevasse](https://otland.net/threads/tutorial-for-running-7-7-cipsoft-server-on-ubuntu.274678/) and [SilverFern](https://otland.net/threads/script-and-tutorial-to-automate-install-of-leaked-7-70-server.284492/) and all the people from OtLand who released this to the public, patched the binary and created required libs.
People from RealOTS who created login server (edited TFS) and query manager for this.