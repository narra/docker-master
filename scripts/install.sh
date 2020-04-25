#!/bin/bash
set -e
set -x

# Update ubuntu
/narra-build/scripts/ubuntu.sh

# NARRA initialization
/narra-build/scripts/narra_init.sh

# Nginx initialization
rm -f /etc/service/nginx/down
rm /etc/nginx/sites-enabled/default
cp /narra-build/nginx/api-narra.conf /etc/nginx/sites-enabled/api-narra.conf
cp /narra-build/nginx/env-narra.conf /etc/nginx/main.d/narra.conf

# Prepare NARRA to update repo while boot
mkdir -p /etc/my_init.d
cp /narra-build/scripts/narra_init.sh /etc/my_init.d/01_narra.sh

# Update nginx run script
cp /narra-build/scripts/nginx_run.sh /etc/service/nginx/run

# Enable the NARRA debug service.
mkdir /etc/service/narra-master-debug
cp /narra-build/scripts/narra_debug.sh /etc/service/narra-master-debug/run
