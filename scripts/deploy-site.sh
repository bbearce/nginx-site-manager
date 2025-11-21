#!/bin/bash
set -e

SITE_NAME=$1

if [ -z "$SITE_NAME" ]; then
    echo "Usage: ./scripts/deploy-site.sh <site-name>"
    exit 1
fi

SITE_FILE="sites/${SITE_NAME}.conf"

if [ ! -f "$SITE_FILE" ]; then
    echo "Error: Site configuration $SITE_FILE not found"
    exit 1
fi

# Ensure SSL folder exists
if [ ! -d "/etc/nginx/ssl" ]; then
    echo "Creating /etc/nginx/ssl folder for SSL certificates."
    sudo mkdir -p /etc/nginx/ssl
fi

openssl req -new -x509 -keyout /etc/nginx/ssl/key_${SITE_NAME}.pem -out /etc/nginx/ssl/crt_${SITE_NAME}.pem -days 365 -nodes \
  -subj "/C=US/ST=Colorado/L=Denver/O=CU Anschutz/OU=QTIM/CN=${DOMAIN}"

echo "Deploying $SITE_NAME..."

# Copy to sites-available
sudo cp "$SITE_FILE" /etc/nginx/sites-available/"$SITE_NAME"

# Enable site (create symlink)
if [ ! -L /etc/nginx/sites-enabled/"$SITE_NAME" ]; then
    sudo ln -s /etc/nginx/sites-available/"$SITE_NAME" /etc/nginx/sites-enabled/"$SITE_NAME"
    echo "✓ Enabled site"
else
    echo "✓ Site already enabled"
fi

# Test configuration
echo "Testing nginx configuration..."
sudo nginx -t

# Reload nginx
echo "Reloading nginx..."
sudo systemctl reload nginx

echo "✓ Deployed $SITE_NAME successfully"