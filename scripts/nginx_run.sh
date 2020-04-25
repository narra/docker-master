#!/bin/bash
set -e
if [ $DEBUG != "true" ]; then
  # We ensure nginx-log-forwarder is running first so it catches the first log-lines
  sv restart /etc/service/nginx-log-forwarder
  exec /usr/sbin/nginx
fi
