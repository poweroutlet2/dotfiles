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

## Claude Code

Custom Claude Code config is stored in `.claude/`:

- **`statusline.sh`** — Custom statusline showing git branch and context window usage

### Agents

#### Web Agents (require [Exa MCP](https://exa.ai/mcp))

- **`agents/web-research.md`** — Multi-step web research agent
- **`agents/web-searcher.md`** — Quick web search agent

#### Documentation Agent (requires [Openground MCP](https://www.openground.ai/))

- **`agents/openground-docs-search.md`** — Official documentation search agent

### Setup

To set up on a new machine, copy the files into `~/.claude/`:

```bash
cp .claude/statusline.sh ~/.claude/statusline.sh
mkdir -p ~/.claude/agents
cp .claude/agents/*.md ~/.claude/agents/
```

## Updating

Pull the latest changes and re-run the install script:

```bash
cd ~/code/dotfiles
git pull
./install.sh
```
