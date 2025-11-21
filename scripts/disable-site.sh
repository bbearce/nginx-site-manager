#!/bin/bash
set -e

SITE_NAME=$1

if [ -z "$SITE_NAME" ]; then
    echo "Usage: ./scripts/disable-site.sh <site-name>"
    exit 1
fi

if [ -L /etc/nginx/sites-enabled/"$SITE_NAME" ]; then
    sudo rm /etc/nginx/sites-enabled/"$SITE_NAME"
    sudo nginx -t && sudo systemctl reload nginx
    echo "✓ Disabled $SITE_NAME"
else
    echo "Site $SITE_NAME is not enabled."
fi