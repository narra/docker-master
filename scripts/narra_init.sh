#!/bin/bash
# Narra initialization
rm -rf /home/app/source

if [[ "$PASSENGER_APP_ENV" == "development" ]]; then
    ln -s /narra_source /home/app/source
else
    mkdir /home/app/source
    git clone https://github.com/narra/platform.git /home/app/source/platform
    # Check for tag
    if [ -n "$NARRA_VERSION" ]; then
        git checkout tags/$NARRA_VERSION
    fi
fi

# Narra post initialization
chown -R app:app /home/app/source
cd /home/app/source/platform

# Narra plugins discovery
pattern_start="##### NARRA PLUGINS #####"
pattern_end="##### END #####"
sed -i "/$pattern_start/,/$pattern_end/d" ./Gemfile
plugins=($(echo $NARRA_PLUGINS | tr ";" "\n"))
echo $pattern_start >> ./Gemfile
for plugin in "${plugins[@]}"
do
    plugin=($(echo $plugin | tr "#" "\n"))
    sudo -u app bundle add ${plugin[0]} --skip-install --git=${plugin[1]}
done
echo $pattern_end >> ./Gemfile

# Installation
sudo -u app bundle install
