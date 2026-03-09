# Directus - TestBot Deployment

TestBot-compatible deployment scripts for Directus data platform.

## Files

- **setup.sh** - Starts Directus, creates collections and seeds data
- **get-token.sh** - Outputs JWT access token
- **docker-compose.yml** - Service configuration (includes PostgreSQL)

## TestBot Configuration

```yaml
- uses: skyramp/testbot@v1
  with:
    skyramp_license_file: ${{ secrets.SKYRAMP_LICENSE }}
    cursor_api_key: ${{ secrets.CURSOR_API_KEY }}
    target_setup_command: './deployment-testbot/directus/setup.sh'
    target_ready_check_command: 'curl -f http://localhost:8055/server/health'
    auth_token_command: './deployment-testbot/directus/get-token.sh'
    target_teardown_command: 'docker-compose -f deployment-testbot/directus/docker-compose.yml down'
```

## Application Details

- **Port:** 8055
- **API Base:** http://localhost:8055
- **Admin Panel:** http://localhost:8055/admin
- **GraphQL:** http://localhost:8055/graphql
- **Health Endpoint:** /server/health
- **Auth Type:** JWT Bearer Token
- **Credentials:** admin@test.com / TestPass123!

## API Endpoints

### Collections
- `GET /collections` - List collections
- `POST /collections` - Create collection

### Items
- `GET /items/{collection}` - List items
- `POST /items/{collection}` - Create item
- `GET /items/{collection}/{id}` - Get item
- `PATCH /items/{collection}/{id}` - Update item
- `DELETE /items/{collection}/{id}` - Delete item

## Manual Testing

```bash
# Start services
./setup.sh

# Get token
TOKEN=$(./get-token.sh)

# Test API
curl http://localhost:8055/items/articles \
  -H "Authorization: Bearer $TOKEN"

# Stop services
docker-compose down
```

## Test Data

Setup script creates:
- **Collection:** articles (id, title, content, status)
- **Items:** 2 published articles
