#!/bin/bash
set -e

# Get authentication token for Directus API

TOKEN=$(curl -s -X POST http://localhost:8055/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"admin@example.com","password":"testpass123"}' \
  | grep -o '"access_token":"[^"]*"' \
  | cut -d'"' -f4)

echo "Bearer $TOKEN"
