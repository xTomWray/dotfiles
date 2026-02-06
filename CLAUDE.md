# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Cross-platform dotfiles repository managed by **chezmoi**, targeting WSL2 Ubuntu 24.04, macOS, and native Linux. Uses `.chezmoiroot` to keep the repo root clean — all chezmoi source state lives in `home/`.

## Key Commands

```sh
# Apply latest dotfiles configuration
cup

# Sync WezTerm config from WSL to Windows host (WSL2 only)
sync-wezterm

# chezmoi workflow
chezmoi diff          # Preview changes before applying
chezmoi apply         # Apply changes from source to home
chezmoi add <file>    # Track a new dotfile
chezmoi edit <file>   # Edit a tracked dotfile's template
chezmoi cd            # cd into chezmoi source directory
```

## Architecture

- **chezmoi** is the dotfiles manager — all config templates, scripts, and state flow through it
- **`.chezmoiroot`** points chezmoi at `home/` so the repo root stays clean for project files
- **`.chezmoi.toml.tmpl`** detects platform (OS, WSL2, Windows username) and prompts for git identity
- **`.chezmoiignore.tmpl`** filters files per-platform (e.g. WezTerm sync script only on WSL2)
- **Install scripts** are numbered (`01-`, `02-`, `03-`) for ordering and use `command -v` guards for idempotency
- **Shell stack**: zsh + starship (prompt) + zinit (plugin manager: autosuggest, completions, syntax highlighting)
- **CLI tools**: fzf, zoxide, direnv, mise (polyglot runtime version manager)
- **WezTerm** config is source-of-truth in WSL/macOS; on WSL2 a `run_onchange` script syncs it to Windows
- **Claude Code** user settings are tracked in `private_dot_claude/`

## Conventions

- All chezmoi source state goes in `home/`, never at the repo root
- Shell scripts use bash for POSIX compatibility; the interactive shell is zsh
- Package installation uses Homebrew on macOS, apt on Ubuntu/WSL2
- Starship requires a Nerd Font enabled in the terminal
- Runtime versions (Node, Python, etc.) are managed by mise, not system packages
- Template conditionals use `.chezmoi.os`, `.is_wsl`, and `.osid` for platform branching
