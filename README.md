# [Spotify Playlist Shuffler](https://spotify-daily-shuffle.mikerogers.io/)

Shuffles a playlist every 24 hours on Spotify. Useful when paired with a Alexa Speaker alarm.

## Setup & Running Locally

Clone down the repo, install [Docker](https://hub.docker.com/editions/community/docker-ce-desktop-mac/). 

### ENVs

Copy the `.env.sample` file to `.env`, within that file the required credentials will be documented.

### Docker

```bash
$ docker-compose build
$ docker-compose run --rm web bin/setup
$ docker-compose up
```
