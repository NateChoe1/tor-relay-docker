FROM archlinux:latest
RUN pacman -Syu --noconfirm tor && rm /etc/tor/torrc
# We want to create a custom config so we remove the default torrc
COPY ./run-tor.sh /run-tor.sh

ENTRYPOINT sh /run-tor.sh
