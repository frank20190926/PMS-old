# Development Principles

<!-- SCOPE: Core development principles, decision framework, and anti-patterns for PMS project -->
<!-- NO_CODE_EXAMPLES: This document defines principles, not implementations -->

## Overview

本文档定义 PMS 项目管理系统的核心开发原则、决策框架和应避免的反模式。

---

## Core Principles (8)

### P1: Single Source of Truth (SSOT)

| Aspect | Guideline |
|--------|-----------|
| Definition | Every piece of data has ONE authoritative source |
| Application | Database is truth for data; code is truth for logic |
| Violation | Duplicating data across tables without sync mechanism |

### P2: Separation of Concerns

| Aspect | Guideline |
|--------|-----------|
| Definition | Each module handles ONE responsibility |
| Application | Controller → Service → Mapper → Database |
| Violation | Business logic in Controller layer |

### P3: Fail Fast

| Aspect | Guideline |
|--------|-----------|
| Definition | Detect and report errors at earliest point |
| Application | Validate input at API boundary |
| Violation | Silent error swallowing, deep error propagation |

### P4: Convention Over Configuration

| Aspect | Guideline |
|--------|-----------|
| Definition | Follow framework conventions; configure only when needed |
| Application | Use RuoYi naming conventions for controllers/services |
| Violation | Custom naming that breaks framework patterns |

### P5: Explicit Over Implicit

| Aspect | Guideline |
|--------|-----------|
| Definition | Make behavior clear through code, not hidden magic |
| Application | Explicit parameter passing, clear method names |
| Violation | Relying on global state, magic strings |

### P6: Least Privilege

| Aspect | Guideline |
|--------|-----------|
| Definition | Grant minimum permissions required |
| Application | Role-based access control, API permission annotations |
| Violation | Admin-only endpoints without permission checks |

### P7: Idempotency

| Aspect | Guideline |
|--------|-----------|
| Definition | Same operation produces same result |
| Application | PUT/DELETE operations, sync mechanisms |
| Violation | Non-idempotent updates, duplicate data on retry |

### P8: Documentation as Code

| Aspect | Guideline |
|--------|-----------|
| Definition | Documentation lives with code, updated together |
| Application | CLAUDE.md, inline comments, Swagger annotations |
| Violation | External docs that drift from implementation |

---

## Decision Framework

### When Adding New Feature

| Step | Question | If Yes | If No |
|------|----------|--------|-------|
| 1 | Does it fit existing module? | Add to module | Create new module |
| 2 | Does it need new API? | Follow API spec | Use existing endpoint |
| 3 | Does it need new table? | Follow DB schema | Use existing tables |
| 4 | Does it affect permissions? | Add RBAC config | Skip permission config |

### When Fixing Bug

| Step | Question | If Yes | If No |
|------|----------|--------|-------|
| 1 | Is root cause clear? | Proceed to fix | Investigate more |
| 2 | Can it regress? | Add test case | Skip test |
| 3 | Does fix affect other areas? | Review dependencies | Apply fix |
| 4 | Is it data-related? | Check data migration | Deploy directly |

### Technology Selection

| Criteria | Weight | Evaluation |
|----------|--------|------------|
| Team familiarity | High | Prefer known technologies |
| Community support | High | Active maintenance, docs |
| Integration ease | Medium | Works with existing stack |
| Performance | Medium | Meets requirements |
| License | Low | Compatible with project |

---

## Anti-Patterns

### A1: God Class

| Aspect | Detail |
|--------|--------|
| Description | Single class doing too many things |
| Symptom | 500+ lines, 20+ methods, mixed concerns |
| Solution | Split by responsibility, extract services |

### A2: Shotgun Surgery

| Aspect | Detail |
|--------|--------|
| Description | One change requires modifying many places |
| Symptom | Adding field requires 5+ file changes |
| Solution | Centralize related logic, use DTOs |

### A3: Premature Optimization

| Aspect | Detail |
|--------|--------|
| Description | Optimizing before identifying bottleneck |
| Symptom | Complex caching for unused features |
| Solution | Measure first, optimize proven bottlenecks |

### A4: Copy-Paste Programming

| Aspect | Detail |
|--------|--------|
| Description | Duplicating code instead of abstracting |
| Symptom | Same logic in multiple controllers |
| Solution | Extract to shared service/utility |

### A5: Magic Numbers/Strings

| Aspect | Detail |
|--------|--------|
| Description | Hard-coded values without explanation |
| Symptom | `if (status == 3)` without constant |
| Solution | Use named constants, enums |

### A6: Ignoring Exceptions

| Aspect | Detail |
|--------|--------|
| Description | Catching exceptions without handling |
| Symptom | Empty catch blocks, silent failures |
| Solution | Log, rethrow, or handle appropriately |

### A7: N+1 Query

| Aspect | Detail |
|--------|--------|
| Description | Executing N queries in loop |
| Symptom | Slow list pages, high DB load |
| Solution | Use JOIN, batch queries, eager loading |

### A8: Circular Dependencies

| Aspect | Detail |
|--------|--------|
| Description | Module A depends on B, B depends on A |
| Symptom | Startup failures, hard to test |
| Solution | Extract common interface, refactor |

---

## Code Conventions

### Java (Backend)

| Convention | Rule |
|------------|------|
| Package | com.app.pms.{module}.{layer} |
| Class naming | PascalCase, Eff prefix for efficiency module |
| Method naming | camelCase, verb prefix (get, save, delete) |
| Constants | UPPER_SNAKE_CASE |

### Vue (Frontend)

| Convention | Rule |
|------------|------|
| Component files | PascalCase.vue |
| Props | camelCase |
| Events | kebab-case |
| Store modules | camelCase |

### Database

| Convention | Rule |
|------------|------|
| Table names | snake_case, module prefix (eff_) |
| Column names | snake_case |
| Primary key | id (bigint, auto increment) |
| Foreign key | {table}_id |
| Timestamps | create_time, update_time |

---

## Verification Checklist

### Before Code Review

| Check | Question |
|-------|----------|
| P1 | Is data sourced from single location? |
| P2 | Is logic in appropriate layer? |
| P3 | Are errors caught at boundary? |
| P4 | Does naming follow convention? |
| P5 | Are dependencies explicit? |
| P6 | Are permissions checked? |
| P7 | Is operation idempotent? |
| P8 | Is documentation updated? |

### Anti-Pattern Scan

| Check | Question |
|-------|----------|
| A1 | Is any class > 300 lines? |
| A2 | Does change touch > 3 files? |
| A3 | Is optimization measured? |
| A4 | Is there duplicated logic? |
| A5 | Are there magic values? |
| A6 | Are exceptions handled? |
| A7 | Are there N+1 queries? |
| A8 | Are there circular imports? |

---

## Maintenance

### Update Triggers

| Trigger | Action |
|---------|--------|
| New principle adopted | Add to Core Principles |
| New anti-pattern identified | Add to Anti-Patterns |
| Convention change | Update Code Conventions |
| Team agreement | Update Decision Framework |

### Verification

- [ ] All 8 principles documented
- [ ] Anti-patterns have solutions
- [ ] Conventions match codebase
- [ ] Decision framework covers common cases

### Last Updated

2026-01-23
