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
      - ./tor-data:/home/tor/tor-data
    environment:
      - RELAY_NICKNAME=natestorrelay
      - RELAY_CONTACT=nate@natechoe.dev
      - RELAY_PORT=200
      - RELAY_EXIT=0
      - RELAY_LOGS=syslog
      - RELAY_BANDWIDTH=25MBytes
          # I can only ever use a maximum of 25MBytes in 1 second
      - RELAY_TRANSFER=10MBytes 
          # Over a long stretch of time, my ISP will only allow 10MBytes of
	  # transfer on average.
      - RELAY_IPV4_ONLY=1
      - RELAY_MAXMEM=1536MBytes
      - RELAY_FAMILY=[some family value]
      - RELAY_ADDRESS=1.1.1.1
    restart:
      always
```

All of this seems pretty self documenting.

If the ```RELAY_EXPERT``` variable is set, then no config file is generated.
Instead, the config file mounted onto `/etc/tor/torrc` is used. You probably
don't want this, it's really only here to allow this docker image to be used for
hidden services.
