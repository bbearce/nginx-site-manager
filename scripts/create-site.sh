#!/bin/bash
set -e

# Check if running from repo root
if [ ! -d "templates" ] || [ ! -d "sites" ]; then
    echo "Error: Must run from repo root directory"
    exit 1
fi

# Get parameters
SITE_NAME=$1
DOMAIN=$2
BACKEND_HOST=${3:-localhost}
BACKEND_PORT=${4:-8000}

if [ -z "$SITE_NAME" ] || [ -z "$DOMAIN" ]; then
    echo "Usage: ./scripts/create-site.sh <site-name> <domain> [backend-host] [backend-port]"
    echo "Example: ./scripts/create-site.sh myapp myapp.example.com localhost 8080"
    exit 1
fi

SITE_FILE="sites/${SITE_NAME}.conf"

# Check if site already exists
if [ -f "$SITE_FILE" ]; then
    echo "Error: Site configuration $SITE_FILE already exists"
    exit 1
fi

# Create config from template
echo "Creating site configuration for $SITE_NAME..."
cp templates/site.conf.template "$SITE_FILE"

# Replace placeholders
sed -i "s/{{SITE_NAME}}/$SITE_NAME/g" "$SITE_FILE"
sed -i "s/{{DOMAIN}}/$DOMAIN/g" "$SITE_FILE"
sed -i "s/{{BACKEND_HOST}}/$BACKEND_HOST/g" "$SITE_FILE"
sed -i "s/{{BACKEND_PORT}}/$BACKEND_PORT/g" "$SITE_FILE"

echo "✓ Created $SITE_FILE"
echo ""
echo "Next steps:"
echo "  1. Review and edit: $SITE_FILE"
echo "  2. Deploy: ./scripts/deploy-site.sh $SITE_NAME"