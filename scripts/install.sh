#!/bin/bash
set -e
set -x

# Update ubuntu
/narra_build/scripts/ubuntu.sh

# Nginx initialization
rm -f /etc/service/nginx/down
rm /etc/nginx/sites-enabled/default
cp /narra_build/nginx/editor-narra.conf /etc/nginx/sites-enabled/editor-narra.conf

# Prepare NARRA to update repo while boot
mkdir -p /etc/my_init.d
cp /narra_build/scripts/narra_init.sh /etc/my_init.d/01_narra.sh

# Update nginx run script
cp /narra_build/scripts/nginx_run.sh /etc/service/nginx/run
