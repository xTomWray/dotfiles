# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

WSL2-first dotfiles repository ("workstation") managed by **chezmoi**, targeting WSL2 Ubuntu 24.04. The actual dotfile templates and scripts live in chezmoi's source directory (`~/.local/share/chezmoi/`); this repo is the upstream source for `chezmoi init --apply`.

## Key Commands

```sh
# Apply latest dotfiles configuration
cup

# Sync WezTerm config from WSL to Windows host
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
- **WezTerm** runs on the Windows side; `~/.wezterm.lua` in WSL is source-of-truth, synced to Windows via `sync-wezterm`
- **Shell stack**: zsh + starship (prompt) + zinit (plugin manager: autosuggest, completions, syntax highlighting)
- **CLI tools**: fzf, zoxide, direnv, mise (polyglot runtime version manager)
- **Claude Code** user settings are tracked in `~/.claude/`

## Conventions

- Starship requires a Nerd Font enabled in WezTerm
- Runtime versions (Node, Python, etc.) are managed by mise, not system packages
