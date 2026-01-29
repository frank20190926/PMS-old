# Efficiency Core Flow E2E Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Implement full E2E coverage for the efficiency core flow (project init → task assignment → daily report → approval → weekly report → write-back) using Playwright.

**Architecture:** Expand Playwright specs in `tests/e2e/tests/` with reusable helpers for login and navigation; use environment variables for credentials; keep tests data-isolated via dedicated test project IDs.

**Tech Stack:** Playwright (Node), existing Vue UI.

---

### Task 1: Add E2E config + helpers

**Files:**
- Modify: `tests/e2e/playwright.config.ts`
- Create: `tests/e2e/tests/helpers/auth.ts`
- Create: `tests/e2e/tests/helpers/navigation.ts`

**Step 1: Write the failing test**
```ts
import { test } from '@playwright/test';

test('placeholder', async () => {
  test.skip();
});
```

**Step 2: Run test to verify it fails**
- N/A (placeholder)

**Step 3: Write minimal implementation**
- Add baseURL + storageState support
- Helpers: login(user, pass), gotoEfficiency()

**Step 4: Run test to verify it passes**
Run: `npx playwright test`
Expected: PASS

**Step 5: Commit**
```bash
git add tests/e2e/tests/helpers tests/e2e/playwright.config.ts
git commit -m "test: add e2e helpers and config"
```

---

### Task 2: Project init / scheduling flow

**Files:**
- Modify: `tests/e2e/tests/project_init.spec.ts`

**Step 1: Write the failing test**
- Validate project status “未排期” before init

**Step 2: Run test to verify it fails**
Run: `npx playwright test tests/project_init.spec.ts`
Expected: FAIL until steps added

**Step 3: Write minimal implementation**
- Login as PM
- Open project list → quick init
- Choose template → auto schedule → save
- Assert task list generated

**Step 4: Run test to verify it passes**
Expected: PASS

**Step 5: Commit**
```bash
git add tests/e2e/tests/project_init.spec.ts
git commit -m "test: e2e project init flow"
```

---

### Task 3: Task assignment + daily report submission

**Files:**
- Modify: `tests/e2e/tests/task_flow.spec.ts`
- Modify: `tests/e2e/tests/daily_report.spec.ts`

**Step 1: Write the failing test**
- Employee sees assigned tasks

**Step 2: Run test to verify it fails**
Expected: FAIL

**Step 3: Write minimal implementation**
- PM assigns tasks
- Employee submits daily report with task details
- Validate submission success

**Step 4: Run test to verify it passes**
Expected: PASS

**Step 5: Commit**
```bash
git add tests/e2e/tests/task_flow.spec.ts tests/e2e/tests/daily_report.spec.ts
git commit -m "test: e2e task assignment and daily report"
```

---

### Task 4: Daily report approval + progress update

**Files:**
- Modify: `tests/e2e/tests/daily_report.spec.ts`

**Step 1: Write the failing test**
- PM approves report

**Step 2: Run test to verify it fails**
Expected: FAIL

**Step 3: Write minimal implementation**
- PM reviews report
- Approve → check task progress updated

**Step 4: Run test to verify it passes**
Expected: PASS

**Step 5: Commit**
```bash
git add tests/e2e/tests/daily_report.spec.ts
git commit -m "test: e2e daily report approval"
```

---

### Task 5: Weekly report generation + submission

**Files:**
- Modify: `tests/e2e/tests/weekly_report.spec.ts`

**Step 1: Write the failing test**
- Ensure auto-generated weekly report exists

**Step 2: Run test to verify it fails**
Expected: FAIL

**Step 3: Write minimal implementation**
- Employee edits and submits weekly report
- Validate submission success

**Step 4: Run test to verify it passes**
Expected: PASS

**Step 5: Commit**
```bash
git add tests/e2e/tests/weekly_report.spec.ts
git commit -m "test: e2e weekly report flow"
```

---

### Task 6: Write-back verification

**Files:**
- Modify: `tests/e2e/tests/task_flow.spec.ts`

**Step 1: Write the failing test**
- Query legacy report list in UI if available

**Step 2: Run test to verify it fails**
Expected: FAIL if not implemented

**Step 3: Write minimal implementation**
- Navigate to legacy report page
- Assert new report exists

**Step 4: Run test to verify it passes**
Expected: PASS

**Step 5: Commit**
```bash
git add tests/e2e/tests/task_flow.spec.ts
git commit -m "test: e2e write-back verification"
```

---

### Task 7: Update test README

**Files:**
- Modify: `tests/README.md`

**Step 1: Write the failing test**
- N/A

**Step 2: Run test to verify it fails**
- N/A

**Step 3: Write minimal implementation**
- Add env vars for PM/employee accounts
- Add preconditions for test data

**Step 4: Run test to verify it passes**
- N/A

**Step 5: Commit**
```bash
git add tests/README.md
git commit -m "docs: update e2e test instructions"
```

---

## Execution Handoff

Plan complete and saved to `docs/plans/2026-01-28-efficiency-e2e-flow-plan.md`. Two execution options:

1. Subagent-Driven (this session) — I dispatch fresh subagent per task, review between tasks, fast iteration
2. Parallel Session (separate) — Open new session with executing-plans, batch execution with checkpoints

Which approach?
