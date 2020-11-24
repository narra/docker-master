#!/bin/bash
set -e
set -x

# update ubuntu
apt-get update
apt-get install -y --force-yes \
    wget \
    sudo \
    rsync
