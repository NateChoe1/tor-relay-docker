#!/bin/sh

apt-get update
apt-get upgrade -y
apt-get install -y unattended-upgrades apt-listchanges
mv /artifacts/50unattended-upgrades /etc/apt/apt.conf.d/50unattended-upgrades
mv /artifacts/20auto-upgrades /etc/apt/apt.conf.d/20auto-upgrades
