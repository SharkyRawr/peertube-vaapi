#!/bin/sh
set -eu

PLUGIN_NAME='peertube-plugin-lunacode-vaapi'
: "${PLUGIN_RETRIES:=12}"
: "${PLUGIN_RETRY_INTERVAL:=5}"

# Install the plugin once the container starts (DB is available here, unlike build time).
# On first boot the database may not be reachable or migrated yet, so retry instead of
# crash-looping; if all attempts fail, start PeerTube anyway and retry on next restart.
attempt=1
installed=false
while [ "$attempt" -le "$PLUGIN_RETRIES" ]; do
  if npm run plugin:list 2>/dev/null | grep -Fq "$PLUGIN_NAME"; then
    echo "PeerTube plugin already installed: $PLUGIN_NAME"
    installed=true
    break
  fi
  if npm run plugin:install -- --npm-name "$PLUGIN_NAME" >/dev/null 2>&1; then
    echo "Installed PeerTube plugin: $PLUGIN_NAME"
    installed=true
    break
  fi
  echo "PeerTube database not ready yet (attempt $attempt/$PLUGIN_RETRIES); retrying in ${PLUGIN_RETRY_INTERVAL}s..." >&2
  attempt=$((attempt + 1))
  sleep "$PLUGIN_RETRY_INTERVAL"
done

if [ "$installed" = false ]; then
  echo "WARNING: could not install $PLUGIN_NAME after $PLUGIN_RETRIES attempts; starting PeerTube without it (will retry on next container restart)." >&2
fi

exec npm start
