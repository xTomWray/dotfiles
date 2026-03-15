# Global Preferences

## Environment

- WSL2 Ubuntu 24.04, zsh + starship + zinit
- Dotfiles managed by chezmoi (repo: xTomWray/dotfiles)
- Runtimes managed by mise (Node, Python, etc.)
- Git identity: xTomWray

## Python

- Target: Python 3.12+
- Modern type syntax: `str | None`, `list[str]`, `dict[str, int]` (not `Optional`, `List`, `Dict`)
- Use PEP 695 type aliases where applicable: `type MyType = str | None`
- Full type annotations on all public functions, including return types
- Async-first with FastAPI/Uvicorn; use `asyncio.TaskGroup` for concurrency
- Pydantic v2 for validation and API models; dataclasses for simple internal data
- Google-style docstrings (Args, Returns, Raises sections)
- EAFP error handling; catch specific exceptions, never bare `except`
- Tooling:
  - **ruff** for linting + formatting (line-length 100, double quotes, select: E, W, F, I, B, C4, UP, ARG, SIM)
  - **mypy** strict mode for type checking
  - **pytest** with pytest-asyncio; unit/integration split in `tests/unit/` and `tests/integration/`
  - **pre-commit** hooks: ruff lint, ruff format, mypy
- Prefer Typer for CLI tools, Makefile as thin wrapper delegating to CLI
- src layout for libraries/medium+ projects; flat layout for scripts/demos

## JavaScript / TypeScript

- React 18 + TypeScript + Material-UI
- Prefer functional components with hooks
- Type all props and return values

## Infrastructure

- Docker: multi-stage builds, non-root user, health checks
- docker-compose with service profiles for deployment variants
- .devcontainer configs for reproducible dev environments

## Git

### One-time setup
Expected global config: `pull.rebase true`, `init.defaultBranch main`, user name/email set.

### Commit messages
Format: `type: short description (max 72 chars)` — optional body after blank line explains *what* and *why*, not *how*.

Types: `feat`, `fix`, `analysis`, `data`, `docs`, `refactor`, `test`, `chore`, `wip` (`wip` must be squashed before merging).

### 11-step workflow
1. Sync main: `git checkout main && git pull --rebase`
2. Create branch: `git checkout -b feature/descriptive-name`
3. Review baseline: `git status` and `git log --oneline` before touching anything
4. Make small, logical changes — one logical unit per commit
5. Stage intentionally: check `git status` first; avoid `git add .`
6. Rebase before pushing: `git fetch origin && git rebase origin/main` (resolve conflicts locally)
7. Push: first time `git push -u origin <branch>`; after rebase `git push --force-with-lease`
8. Open PR with description: what changed / why / how to test / notes; link related issues
9. Address review feedback with **new commits** — never amend or force-push during active review
10. Merge via **Squash & Merge** (default) or Rebase & Merge for already-clean branches; never merge commits
11. Delete local and remote branch after merging

### Force push rules
- Always `--force-with-lease`; never plain `--force`
- OK on your own feature branch before PR opens (step 7)
- Never during active review — add new commits instead (step 9)
- Never on shared branches or main

### .gitignore
Always cover: Python build artifacts (`__pycache__`, `*.pyc`, `.venv`), Jupyter checkpoints (`.ipynb_checkpoints`), generated outputs, OS files (`.DS_Store`, `Thumbs.db`), IDE configs (`.vscode`, `.idea`), secrets (`.env`, `.env.local`, `*.pem`, `*.key`).

### Research hygiene
- **Commit**: environment/lock files (`requirements.txt`, `package-lock.json`)
- **Never commit**: secrets (rotate immediately if leaked; use `git filter-branch` to purge), generated outputs
- Tag milestones: `git tag -a v1.0-name`
- Record commit SHA in run logs for artifact traceability

### Branch protection (new repos)
Enable: require PR before merging, 1+ approvals, dismiss stale approvals, require passing status checks, require up-to-date branch. Disable: force pushes and deletions on main.

## General

- Keep code simple; don't over-engineer or add speculative abstractions
- Only add comments where logic isn't self-evident
- Validate at system boundaries (user input, external APIs), trust internal code
- Prefer editing existing files over creating new ones
