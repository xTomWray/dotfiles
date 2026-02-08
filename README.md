# dotfiles

Cross-platform dotfiles managed by [chezmoi](https://chezmoi.io/). One repo, one command — targets WSL2 Ubuntu 24.04, macOS, and native Linux.

## Stack

| Layer | Tool |
|-------|------|
| Shell | zsh + zinit (autosuggest, completions, syntax highlighting) |
| Prompt | starship (requires a [Nerd Font](https://www.nerdfonts.com/)) |
| Terminal | WezTerm (auto-synced to Windows host on WSL2) |
| CLI | fzf, zoxide, direnv |
| Runtimes | mise (Node, Python, etc.) |
| AI | Claude Code (global preferences + settings) |
| Git | Templated identity via chezmoi |

## Install

```sh
# Prerequisites on a fresh WSL2 Ubuntu install
sudo apt update && sudo apt install -y git curl

# Bootstrap everything
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ~/.local/bin init --apply xTomWray/dotfiles
```

Chezmoi prompts for git name and email on first run. Platform, WSL2, and Windows username are detected automatically.

## Usage

| Command | Description |
|---------|-------------|
| `cup` | Pull latest dotfiles and apply |
| `chezmoi diff` | Preview pending changes |
| `chezmoi apply` | Apply changes |
| `chezmoi add <file>` | Track a new dotfile |
| `chezmoi edit <file>` | Edit a tracked template |

## Repo structure

`.chezmoiroot` points chezmoi at `home/`, keeping the repo root clean.

```
dotfiles/
├── CLAUDE.md                           # repo-level Claude Code instructions
├── bin/chezmoi                         # chezmoi binary (bootstrap)
├── home/
│   ├── .chezmoi.toml.tmpl             # platform detection + identity prompts
│   ├── .chezmoiignore.tmpl            # per-OS file filtering
│   ├── .chezmoiscripts/               # numbered install scripts (idempotent)
│   ├── dot_zshrc.tmpl                 # zsh config
│   ├── dot_zprofile.tmpl              # login env (Homebrew path on macOS)
│   ├── dot_wezterm.lua.tmpl           # WezTerm terminal config
│   ├── dot_config/
│   │   ├── starship.toml              # prompt theme + modules
│   │   └── private_git/               # git config + global ignore
│   └── private_dot_claude/
│       ├── CLAUDE.md                  # global Claude Code preferences
│       └── settings.json              # Claude Code user settings
```
