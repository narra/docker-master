#!/bin/bash
# Narra initialization
rm -rf /home/app/source

if [[ "$PASSENGER_APP_ENV" == "development" ]]; then
    mkdir -p /home/app/source/angular-editor/dist/editor && rsync -a /narra_source/angular-editor/dist/editor/ /home/app/source/angular-editor/dist/editor
else
    mkdir /home/app/source
    git clone https://github.com/narra/angular-editor.git /home/app/source/angular-editor
    # Check for tag
    if [ -n "$NARRA_EDITOR_VERSION" ]; then
        git checkout tags/$NARRA_EDITOR_VERSION
    fi
fi

# Set ENV for Angular
cat > /home/app/source/angular-editor/dist/editor/assets/environment.json <<EOF
    {
      "NARRA_API_HOSTNAME": "$NARRA_API_HOSTNAME"
    }
EOF

# Narra post initialization
chown -R app:app /home/app/source/angular-editor
