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

- Concise commit messages: imperative mood, focus on "why" not "what"
- Never force-push to main
- Use conventional commit style when project uses it

## General

- Keep code simple; don't over-engineer or add speculative abstractions
- Only add comments where logic isn't self-evident
- Validate at system boundaries (user input, external APIs), trust internal code
- Prefer editing existing files over creating new ones
