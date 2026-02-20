#!/bin/sh
set -eu

PLUGIN_NAME='peertube-plugin-lunacode-vaapi'

# Install the plugin once the container starts (DB is available here, unlike build time).
if npm run plugin:list 2>/dev/null | grep -Fq "$PLUGIN_NAME"; then
  echo "PeerTube plugin already installed: $PLUGIN_NAME"
else
  echo "Installing PeerTube plugin: $PLUGIN_NAME"
  npm run plugin:install -- --npm-name "$PLUGIN_NAME"
fi

exec npm start
