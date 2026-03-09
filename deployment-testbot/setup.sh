#!/bin/bash
set -e

# TestBot Setup Script for Directus
# This script starts Directus service and creates collections with test data

cd "$(dirname "$0")"

echo "Starting Directus service..."
docker compose up -d

echo "Waiting for service to be ready..."
sleep 20

echo "Logging in to get access token..."
API_BASE="http://localhost:8055"
EMAIL="admin@test.com"
PASSWORD="TestPass123!"

# Login to get token
TOKEN=$(curl -s -X POST "$API_BASE/auth/login" \
  -H "Content-Type: application/json" \
  -d "{\"email\":\"$EMAIL\",\"password\":\"$PASSWORD\"}" \
  | jq -r '.data.access_token')

echo "Creating 'articles' collection..."
collection_payload='{
  "collection": "articles",
  "meta": {"collection": "articles", "icon": "article"},
  "schema": {"name": "articles"},
  "fields": [
    {"field": "id", "type": "integer", "meta": {"hidden": true, "readonly": true}, "schema": {"is_primary_key": true, "has_auto_increment": true}},
    {"field": "title", "type": "string", "meta": {"interface": "input", "required": true}, "schema": {"max_length": 255}},
    {"field": "content", "type": "text", "meta": {"interface": "input-rich-text-html"}},
    {"field": "status", "type": "string", "meta": {"interface": "select-dropdown"}, "schema": {"default_value": "draft"}}
  ]
}'

curl -s -X POST "$API_BASE/collections" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d "$collection_payload" > /dev/null 2>&1 || true

sleep 2

echo "Seeding test data..."
curl -s -X POST "$API_BASE/items/articles" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"title":"Getting Started","content":"<p>Tutorial content...</p>","status":"published"}' > /dev/null

curl -s -X POST "$API_BASE/items/articles" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"title":"API Testing","content":"<p>Testing guide...</p>","status":"published"}' > /dev/null

echo "✓ Directus setup complete"
