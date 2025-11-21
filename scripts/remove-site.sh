#!/bin/bash
set -e

SITE_NAME=$1

if [ -z "$SITE_NAME" ]; then
    echo "Usage: ./scripts/remove-site.sh <site-name>"
    exit 1
fi

if [ -f /etc/nginx/sites-available/"$SITE_NAME" ]; then
    sudo rm /etc/nginx/sites-available/"$SITE_NAME"
    sudo nginx -t && sudo systemctl reload nginx
    echo "✓ Removed $SITE_NAME"
else
    echo "Site $SITE_NAME is removed."
fi