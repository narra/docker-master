#!/bin/bash
set -e
set -x

# Update ubuntu
/narra_build/scripts/ubuntu.sh

# Prepare ruby and update bundler
#rvm-exec gem install bundler
rvm-exec default gem install bundler

# NARRA initialization
/narra_build/scripts/narra_init.sh

# Nginx initialization
rm -f /etc/service/nginx/down
rm /etc/nginx/sites-enabled/default
cp /narra_build/nginx/api-narra.conf /etc/nginx/sites-enabled/api-narra.conf
cp /narra_build/nginx/env-narra.conf /etc/nginx/main.d/narra.conf

# Prepare NARRA to update repo while boot
mkdir -p /etc/my_init.d
cp /narra_build/scripts/narra_init.sh /etc/my_init.d/01_narra.sh

# Update nginx run script
cp /narra_build/scripts/nginx_run.sh /etc/service/nginx/run

# Enable the NARRA debug service.
mkdir /etc/service/narra-master-debug
cp /narra_build/scripts/narra_debug.sh /etc/service/narra-master-debug/run
