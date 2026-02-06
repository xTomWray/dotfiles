# workstation (WSL2-first dotfiles)

This repo is intended to be applied with chezmoi **inside WSL2 Ubuntu 24.04**.
It configures:
- zsh + starship + zinit (autosuggest, completions, syntax highlighting)
- fzf + zoxide + direnv + mise
- Claude Code user settings in ~/.claude/
- WezTerm config tracked as ~/.wezterm.lua (then synced to Windows via sync-wezterm)

## Install (WSL2 Ubuntu)
1) Install basics:
   sudo apt update && sudo apt install -y git curl

2) Install chezmoi:
   sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ~/.local/bin
   export PATH="$HOME/.local/bin:$PATH"

3) Init + apply (replace repo):
   chezmoi init --apply xTomWray/workstation

## Daily commands
- Apply latest: cup
- Sync WezTerm to Windows host: sync-wezterm

## Notes
- Starship works best with a Nerd Font enabled in WezTerm.
- WezTerm runs on Windows; ~/.wezterm.lua in WSL is the source-of-truth that gets copied over.
