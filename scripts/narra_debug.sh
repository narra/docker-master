#!/bin/bash
# NARRA Debug

cd /home/app/source/platform

if [ $DEBUG == "true" ]; then
  exec /sbin/setuser app /usr/bin/bundle exec rdebug-ide --host 0.0.0.0 --port 1234 --dispatcher-port 26162 -- /home/app/source/platform/bin/rails s -b 0.0.0.0 -p 8080 -e development
fi
