#!/bin/bash
# Auto-format file after Claude writes/edits it.
# Language-aware: ruff for Python, prettier for JS/TS/web.
# Always exits 0 — formatting is best-effort, never blocks Claude.

input=$(cat)
file=$(echo "$input" | jq -r '.tool_input.file_path // empty')
[[ -z "$file" || ! -f "$file" ]] && exit 0

case "${file##*.}" in
  py)
    ruff format --quiet "$file" 2>/dev/null
    ruff check --fix --quiet "$file" 2>/dev/null
    ;;
  js|ts|tsx|jsx|css|scss|json|md|yaml|yml)
    prettier --write --log-level=error "$file" 2>/dev/null
    ;;
esac
exit 0
