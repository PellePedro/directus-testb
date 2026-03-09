#!/bin/bash
set -e

# TestBot Setup Script for Directus
# This script starts Directus service

cd "$(dirname "$0")"

echo "Current directory: $(pwd)"
echo "Starting Directus service..."
docker compose up -d

echo "Waiting for service to be ready..."
sleep 20

echo "Checking container status..."
docker compose ps

echo "✓ Directus setup complete"
