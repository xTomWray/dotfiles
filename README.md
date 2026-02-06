# dotfiles

Cross-platform dotfiles managed by [chezmoi](https://chezmoi.io/). Targets **WSL2 Ubuntu**, **macOS**, and **native Linux** with a single repo and one-command setup.

## What you get

- **zsh** + starship (prompt) + zinit (plugins: autosuggest, completions, syntax highlighting)
- **CLI tools**: fzf, zoxide, direnv, mise
- **Git** config with templated identity
- **WezTerm** config (WSL2: auto-synced to Windows host)
- **Claude Code** user settings

## Install

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply xTomWray/dotfiles
```

On a fresh WSL2 Ubuntu install, you may need `git` and `curl` first:

```sh
sudo apt update && sudo apt install -y git curl
```

On first run, chezmoi will prompt for your git name and email. Everything else is detected automatically.

## Daily commands

| Command | Description |
|---------|-------------|
| `cup` | Pull latest dotfiles and apply |
| `sync-wezterm` | Copy WezTerm config to Windows (WSL2 only) |
| `chezmoi diff` | Preview pending changes |
| `chezmoi apply` | Apply changes from source to home |
| `chezmoi add <file>` | Track a new dotfile |
| `chezmoi edit <file>` | Edit a tracked template |

## Repo structure

The repo uses `.chezmoiroot` so the project root stays clean. All chezmoi source state lives in `home/`:

```
dotfiles/
├── .chezmoiroot          # points chezmoi at home/
├── home/
│   ├── .chezmoi.toml.tmpl    # platform detection + prompts
│   ├── .chezmoiignore.tmpl   # per-OS file filtering
│   ├── .chezmoiscripts/      # install scripts (apt/brew, zinit, starship, etc.)
│   ├── dot_zshrc.tmpl        # zsh config
│   ├── dot_zprofile.tmpl     # login env (Homebrew on macOS)
│   ├── dot_wezterm.lua.tmpl  # WezTerm terminal config
│   ├── dot_config/
│   │   ├── starship.toml     # prompt config
│   │   └── private_git/      # git config + global ignore
│   └── private_dot_claude/   # Claude Code settings
```

## Notes

- Starship requires a [Nerd Font](https://www.nerdfonts.com/) enabled in your terminal
- Runtime versions (Node, Python, etc.) are managed by mise, not system packages
- WezTerm runs natively on Windows/macOS; on WSL2 the config is synced automatically
