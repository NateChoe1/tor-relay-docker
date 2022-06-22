FROM debian:stable-slim
COPY ./artifacts /artifacts
RUN sh /artifacts/setup-auto-upgrades.sh
RUN sh /artifacts/install-tor.sh

ENTRYPOINT sh /artifacts/run-tor.sh
