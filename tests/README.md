# Tests

## API
- Install: `pip install -r tests/api/requirements.txt`
- Run: `pytest tests/api -q`

## E2E
- Install: `cd tests/e2e && npm install`
- Run: `cd tests/e2e && npx playwright test`

## Env
- `PMS_BASE_URL` (default http://localhost:8090)
- `PMS_UI_URL` (default http://localhost:1025)
