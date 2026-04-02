---
name: review-pr
description: >-
  Full pre-PR review: analyse the diff against main, run build/lint/type/test
  verification, and perform a security scan, then produce a gated readiness
  report. TRIGGER when: user says "review changes", "review PR", "ready to PR",
  "check before merge", or asks for a pre-PR review. Do NOT trigger when the
  user just wants to create/push a PR without a quality gate.
origin: local
---

# Review PR Skill

Run this skill before opening a PR to catch issues early and produce a
structured readiness report.

## Phases

### Phase 1 — Diff Analysis

```bash
# Which branch are we on and how far ahead of main?
git log --oneline main..HEAD

# Summary of all changed files
git diff main...HEAD --stat

# Full diff for close reading (limit noise)
git diff main...HEAD -- '*.py' '*.ts' '*.tsx' '*.js' | head -400
```

Review the diff for:
- Unintended file changes (lockfiles, generated files, .env)
- Logic that could break existing behaviour
- Missing error handling or edge cases
- Large functions that should be split
- TODO / FIXME / debug prints left in

---

### Phase 2 — Build & Type Check

Run whichever apply to this project:

```bash
# Python
python -m py_compile $(git diff main...HEAD --name-only --diff-filter=d | grep '\.py$') 2>&1 | head -20
mypy . --ignore-missing-imports 2>&1 | tail -20

# TypeScript
npx tsc --noEmit 2>&1 | head -30

# C++ (if CMakeLists.txt present)
cmake -B build -DCMAKE_BUILD_TYPE=Release 2>&1 | tail -10 && cmake --build build --parallel 2>&1 | tail -20
```

If build or type check **FAILS** → stop, fix, re-run.

---

### Phase 3 — Lint

```bash
# Python
ruff check . 2>&1 | head -30
ruff format --check . 2>&1 | head -10

# TypeScript / JavaScript
npx eslint . 2>&1 | head -30

# Pre-commit (runs all configured hooks)
pre-commit run --all-files 2>&1 | tail -30
```

---

### Phase 4 — Tests

```bash
# Python
pytest --tb=short -q 2>&1 | tail -30
pytest --cov=src --cov-report=term-missing --cov-fail-under=80 2>&1 | tail -20

# TypeScript / JavaScript
npm test -- --coverage 2>&1 | tail -30
```

Report:
- Total / Passed / Failed
- Coverage % (must be ≥ 80%)

---

### Phase 5 — Security Scan

```bash
# Secrets in changed files only
git diff main...HEAD | grep -iE '(api_key|secret|password|token|private_key)\s*=\s*["\x27][^"\x27]{6,}' | head -20

# Python: bandit on changed source files
bandit -r src/ -ll 2>&1 | head -30

# Dependency vulnerabilities
# Python
pip-audit 2>&1 | head -20
# Node
npm audit --audit-level=high 2>&1 | head -20
```

Flag anything CRITICAL or HIGH immediately — do not proceed to PR until resolved.

For a deep security review invoke the `security-review` skill.

---

### Phase 6 — PR Readiness Report

After all phases produce the following report:

```
PR READINESS REPORT
===================
Branch:    <branch-name>
Commits:   <N> ahead of main
Files:     <N> changed, <+ins> insertions, <-del> deletions

Build:     [PASS / FAIL]
Types:     [PASS / FAIL]  (<N> errors)
Lint:      [PASS / FAIL]  (<N> warnings)
Tests:     [PASS / FAIL]  (<N>/<N> passed, <N>% coverage)
Security:  [PASS / FAIL]  (<N> issues)

Overall:   [READY / NOT READY] for PR

Blockers (must fix before PR):
1. ...

Warnings (address in follow-up or PR notes):
1. ...
```

Only proceed to `gh pr create` when Overall = **READY**.

---

## Quick Mode

When there is no build system (docs-only change, scaffold, etc.) skip phases 2–4
and note "N/A — no source files changed" in the report.
