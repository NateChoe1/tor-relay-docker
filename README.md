# Dockerized tor relay

I really don't think this amount of code is copyrightable, so I'm putting this
in the public domain. This is just a dockerized tor relay.

## Usage:

Create a docker-compose.yml which looks something like this

```
# Sample docker-compose.yml

version: "3.0"

services:
  relay:
    image: natechoe/tor-relay
    container_name: tor-relay
    hostname: tor-relay
    ports:
      - "200:200"
    volumes:
      - ./tor-data:/var/lib/tor/
    environment:
      - RELAY_NICKNAME=natestorrelay
      - RELAY_CONTACT=nate@natechoe.dev
      - RELAY_PORT=200
      - RELAY_EXIT=0
      - RELAY_LOGS=syslog
      - RELAY_BANDWIDTH=25MBytes
    restart:
      always
```

All of this seems pretty self documenting.
