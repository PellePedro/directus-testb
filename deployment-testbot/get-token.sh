#!/bin/bash
# TestBot Auth Token Script for Directus
# Logs in and outputs JWT access token

API_BASE="http://localhost:8055"
EMAIL="admin@test.com"
PASSWORD="TestPass123!"

TOKEN=$(curl -s -X POST "$API_BASE/auth/login" \
  -H "Content-Type: application/json" \
  -d "{\"email\":\"$EMAIL\",\"password\":\"$PASSWORD\"}" \
  | jq -r '.data.access_token')

echo "$TOKEN"
