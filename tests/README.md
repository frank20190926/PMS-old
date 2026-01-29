# Tests

## API
- Install: `pip install -r tests/api/requirements.txt`
- Run: `pytest tests/api -q`

## E2E
- Install: `cd tests/e2e && npm install`
- Run: `cd tests/e2e && npx playwright test`

## Env
- `PMS_BASE_URL` (default http://localhost:8090)
- `PMS_UI_URL` (default http://localhost:1024)
- `PMS_PM_USER` / `PMS_PM_PASS` (项目经理账号)
- `PMS_EMP_USER` / `PMS_EMP_PASS` (员工账号)
- `PMS_EMP_NAME` (员工显示名称，用于任务分配和回写校验)

## Notes
- E2E 默认使用 API 登录并写入前端 token；需确保 `PMS_BASE_URL` 可访问。
- E2E 默认假设验证码关闭；若开启，请先在后端配置中关闭后再运行。
