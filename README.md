# Dotfiles

Personal dotfiles for setting up a new Linux system.

## What's Included

- **Zsh** with Powerlevel10k prompt
- **Antidote** plugin manager with: zsh-completions, zsh-autosuggestions, fzf-tab, zsh-syntax-highlighting
- **Tmux** config with mouse support
- **JetBrains Mono Nerd Font** for Powerlevel10k icons

## What Gets Installed

- Neovim
- Tmux
- Astral UV (Python)
- NVM + Node.js (latest)
- Bun
- pnpm
- Git (with config)
- Fzf
- Various CLI tools (curl, wget, jq, unzip, etc.)

## Setup

On a fresh system:

```bash
# Clone the repo
git clone https://github.com/poweroutlet2/dotfiles.git ~/code/dotfiles

# Run the install script
cd ~/code/dotfiles
./install.sh
```

Then:
1. Add the displayed SSH key to GitHub (https://github.com/settings/ssh/new)
2. Log out and back in for Zsh to become your default shell
3. Restart your terminal

## Updating

Pull the latest changes and re-run the install script:

```bash
cd ~/code/dotfiles
git pull
./install.sh
```
