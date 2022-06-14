FROM archlinux:latest
RUN pacman -Syu --noconfirm tor
VOLUME /var/lib/tor
COPY ./run-tor.sh /run-tor.sh

ENTRYPOINT sh /run-tor.sh
