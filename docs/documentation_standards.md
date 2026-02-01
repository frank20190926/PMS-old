# Documentation Standards

<!-- SCOPE: Defines 60+ documentation requirements for consistent, high-quality project documentation -->
<!-- NO_CODE_EXAMPLES: This document defines standards, not implementations -->

## Quick Reference

| Category | Requirement Count | Priority |
|----------|-------------------|----------|
| Structure | 12 | Critical |
| Content | 15 | Critical |
| Format | 10 | High |
| Maintenance | 8 | High |
| Links | 5 | Medium |
| Language | 5 | Medium |
| Validation | 5 | Medium |

---

## 1. Document Structure Standards

### 1.1 SCOPE Tag (MANDATORY)

Every document MUST include a SCOPE tag in the first 10 lines:

```
<!-- SCOPE: Brief description of document purpose and boundaries -->
```

### 1.2 Section Requirements

| Section | Required | Purpose |
|---------|----------|---------|
| Title (H1) | Yes | Single H1 with document name |
| SCOPE tag | Yes | Purpose and boundaries |
| Overview | Yes | Brief summary |
| Main Content | Yes | Core information |
| Maintenance | Yes | Update triggers, verification, last updated |

### 1.3 Heading Hierarchy

| Rule | Description |
|------|-------------|
| Single H1 | Only one H1 per document |
| Sequential | No skipping levels (H1 → H2 → H3) |
| Max Depth | H4 maximum, prefer H3 |

---

## 2. Content Standards

### 2.1 NO_CODE Rule

| Document Type | Code Allowed | Reason |
|---------------|--------------|--------|
| Root docs (CLAUDE.md, README.md) | Command examples only | Navigation focus |
| Standards docs | Syntax examples only | Pattern definition |
| API specs | Schema definitions | Contract definition |
| Implementation guides | Full code blocks | Implementation focus |

### 2.2 Placeholder Handling

| Placeholder Type | Format | Example |
|------------------|--------|---------|
| Missing data | `[TBD: description]` | `[TBD: Add database schema]` |
| Variable | `{{VARIABLE_NAME}}` | `{{PROJECT_NAME}}` (in templates only) |
| Never allowed | Empty sections | (delete or mark TBD) |

### 2.3 Completeness Requirements

| Rule | Description |
|------|-------------|
| No empty sections | Every section must have content or TBD marker |
| No broken links | All internal links must resolve |
| No orphan docs | Every doc linked from navigation |

---

## 3. Format Standards

### 3.1 Format Priority

```
Tables/ASCII > Lists > Text
```

| Priority | Use When | Example |
|----------|----------|---------|
| 1. Tables | Structured data, comparisons | Feature matrix |
| 2. ASCII diagrams | Architecture, flows | Component diagram |
| 3. Lists | Enumerations only | Feature list |
| 4. Text | Last resort | Explanatory paragraphs |

### 3.2 Table Standards

| Rule | Description |
|------|-------------|
| Header row | Always include |
| Alignment | Left-align text, right-align numbers |
| Width | Keep cells concise (< 50 chars) |
| Empty cells | Use `-` or `N/A` |

### 3.3 List Standards

| Rule | Description |
|------|-------------|
| Use for | Enumerations, steps, options |
| Avoid | Paragraphs disguised as lists |
| Nesting | Max 2 levels |
| Consistency | Same grammatical structure |

---

## 4. Maintenance Standards

### 4.1 Maintenance Section (MANDATORY)

Every document MUST end with a Maintenance section containing:

| Subsection | Purpose |
|------------|---------|
| Update Triggers | When to update this document |
| Verification Checklist | How to validate document accuracy |
| Last Updated | Date in YYYY-MM-DD format |

### 4.2 Update Triggers

| Trigger Type | Example |
|--------------|---------|
| Code change | "Update when API endpoints change" |
| Dependency | "Update when package.json changes" |
| Process | "Update when deployment process changes" |

### 4.3 Version Control

| Rule | Description |
|------|-------------|
| Last Updated | Always update on modification |
| Change log | Optional, in separate section if needed |
| Git history | Primary version tracking |

---

## 5. Link Standards

### 5.1 Internal Links

| Rule | Description |
|------|-------------|
| Relative paths | Always use relative paths |
| Anchor links | Use for long documents |
| Validation | Check all links on creation |

### 5.2 External Links

| Rule | Description |
|------|-------------|
| Stack matching | Links must match project stack |
| Official docs | Prefer official documentation |
| Stability | Avoid links to volatile content |

### 5.3 Stack Adaptation

| Project Stack | Preferred Sources |
|---------------|-------------------|
| Java/Spring | Spring.io, Oracle docs |
| Vue.js | vuejs.org, Element UI docs |
| MySQL | MySQL docs, dev.mysql.com |

---

## 6. Language Standards

### 6.1 Language Selection

| Document Type | Language |
|---------------|----------|
| Business requirements | 中文 |
| User stories | 中文 |
| Technical specs | English |
| API documentation | English |
| Code comments | English |

### 6.2 Terminology

| Rule | Description |
|------|-------------|
| Consistency | Same term for same concept |
| Glossary | Define project-specific terms |
| Abbreviations | Define on first use |

---

## 7. Validation Standards

### 7.1 Self-Validation Checklist

| Check | Requirement |
|-------|-------------|
| SCOPE tag | Present in first 10 lines |
| Single H1 | Only one H1 heading |
| Maintenance section | Present at end |
| No empty sections | All sections have content |
| POSIX ending | Single newline at file end |

### 7.2 Cross-Validation

| Check | Requirement |
|-------|-------------|
| Links | All internal links resolve |
| Navigation | Document listed in README.md |
| Consistency | Terms match glossary |

---

## 8. File Naming Standards

### 8.1 Document Files

| Rule | Format | Example |
|------|--------|---------|
| Case | snake_case | api_spec.md |
| Extension | .md | Always markdown |
| Descriptive | Clear purpose | database_schema.md |

### 8.2 Directory Structure

| Rule | Format | Example |
|------|--------|---------|
| Case | lowercase | project/, reference/ |
| Grouping | By purpose | adrs/, guides/ |

---

## 9. Diagram Standards

### 9.1 ASCII Diagrams

| Use For | Tool |
|---------|------|
| Simple flows | Manual ASCII |
| Component diagrams | ASCII boxes |
| Sequence diagrams | Text-based |

### 9.2 Image Diagrams

| Rule | Description |
|------|-------------|
| Format | PNG or SVG preferred |
| Location | assets/ directory |
| Alt text | Always include |
| Size | Reasonable for viewing |

---

## 10. API Documentation Standards

### 10.1 Endpoint Documentation

| Field | Required | Description |
|-------|----------|-------------|
| Method | Yes | HTTP method |
| Path | Yes | URL path |
| Description | Yes | What it does |
| Request | Yes | Body/params schema |
| Response | Yes | Response schema |
| Errors | Yes | Error codes and meanings |

### 10.2 Schema Documentation

| Field | Required | Description |
|-------|----------|-------------|
| Field name | Yes | Property name |
| Type | Yes | Data type |
| Required | Yes | Yes/No |
| Description | Yes | Purpose |
| Example | Recommended | Sample value |

---

## 11. Database Documentation Standards

### 11.1 Table Documentation

| Field | Required | Description |
|-------|----------|-------------|
| Table name | Yes | Full table name |
| Purpose | Yes | What data it stores |
| Columns | Yes | All columns with types |
| Indexes | Yes | Index definitions |
| Relationships | Yes | Foreign keys |

### 11.2 Column Documentation

| Field | Required | Description |
|-------|----------|-------------|
| Name | Yes | Column name |
| Type | Yes | Data type with size |
| Nullable | Yes | Yes/No |
| Default | If exists | Default value |
| Description | Yes | Purpose |

---

## 12. Architecture Documentation Standards

### 12.1 Component Documentation

| Field | Required | Description |
|-------|----------|-------------|
| Name | Yes | Component name |
| Purpose | Yes | What it does |
| Dependencies | Yes | What it depends on |
| Interfaces | Yes | How to interact |

### 12.2 Decision Records (ADRs)

| Section | Required | Description |
|---------|----------|-------------|
| Title | Yes | Decision title |
| Status | Yes | Proposed/Accepted/Deprecated |
| Context | Yes | Why this decision |
| Decision | Yes | What was decided |
| Consequences | Yes | Impact of decision |

---

## Maintenance

### Update Triggers

| Trigger | Action |
|---------|--------|
| New standard added | Add to relevant section |
| Standard deprecated | Mark as deprecated, not delete |
| Requirement count changes | Update Quick Reference table |

### Verification Checklist

- [ ] All 60+ requirements documented
- [ ] Quick Reference counts accurate
- [ ] No conflicting standards
- [ ] Examples match current stack

### Last Updated

2026-01-23
