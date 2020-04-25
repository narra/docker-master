#!/bin/bash
# Use the exec command to start the app you want to run in this container.
# Don't let the app daemonize itself.

# `/sbin/setuser memcache` runs the given command as the user `memcache`.
# If you omit that part, the command will be run as root.

# Read more here: https://github.com/phusion/baseimage-docker#adding-additional-daemons
cd /home/app/source/narra

if [ $DEBUG == "true" ]; then
    exec /sbin/setuser app /usr/bin/bundle exec rdebug-ide --host 0.0.0.0 --port 1234 --dispatcher-port 26162 -- /home/app/source/narra/bin/rails s -b 0.0.0.0 -p 8080 -e development
fi
