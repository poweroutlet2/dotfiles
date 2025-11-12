#!/usr/bin/env bash
set -e

echo "Updating package lists and upgrading..."
sudo apt update
sudo apt upgrade

echo "Installing prerequisites..."
sudo apt install -y curl wget gnupg2 software-properties-common git build-essential zsh fontconfig jq fzf unzip

# Git stuff
echo "Setting git config stuff..."
git config --global init.defaultBranch main
git config --global user.name "Harsh Patel"
git config --global user.email "harshp2015i@gmail.com"


# Install JetBrains Mono Nerd Font
if ! fc-list | grep -i "JetBrainsMono Nerd Font" >/dev/null 2>&1; then
  echo "Installing JetBrains Mono Nerd Font..."
  FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip"
  wget -O /tmp/jetbrains.zip "$FONT_URL"
  mkdir -p ~/.local/share/fonts
  unzip -o /tmp/jetbrains.zip -d ~/.local/share/fonts/
  fc-cache -fv
  rm /tmp/jetbrains.zip
fi


# Install Oh My Posh and set up Zsh config
if ! command -v oh-my-posh >/dev/null 2>&1; then
  echo "Installing Oh My Posh..."
  curl -s https://ohmyposh.dev/install.sh | bash -s
fi

# Add ~/.local/bin to PATH if it exists
if [ -d "$HOME/.local/bin" ] ; then
  PATH="$HOME/.local/bin:$PATH"
fi

# Set Zsh as default shell if not already
if [ "$SHELL" != "$(which zsh)" ]; then
  chsh -s "$(which zsh)"
  echo "Default shell changed to Zsh. Please log out and log back in for changes to take effect."
fi

# Add Oh My Posh init to zshrc if not present
if ! grep -q "oh-my-posh init zsh" ~/.zshrc 2>/dev/null; then
  echo 'eval "$(oh-my-posh init zsh --config ~/.poshthemes/jandedobbeleer.omp.json)"' >> ~/.zshrc
fi

# Generate SSH key for GitHub if not present
if [ ! -f ~/.ssh/id_ed25519 ]; then
  echo "Generating SSH key for GitHub..."
  read -p "Enter your GitHub email address: " github_email
  ssh-keygen -t ed25519 -C "$github_email" -f ~/.ssh/id_ed25519 -N ""
  
  # Start ssh-agent and add key
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_ed25519
  
  echo ""
  echo "=========================================="
  echo "Your SSH public key (add this to GitHub):"
  echo "=========================================="
  cat ~/.ssh/id_ed25519.pub
  echo ""
  echo "Copy the above key and add it to GitHub at:"
  echo "https://github.com/settings/ssh/new"
  echo "=========================================="
fi

# Set up fzf for Zsh
if ! grep -q "fzf --zsh" ~/.zshrc 2>/dev/null; then
  echo "Setting up fzf shell integration for Zsh..."
  echo 'source <(fzf --zsh)' >> ~/.zshrc
fi

# Install Neovim
if ! command -v nvim >/dev/null 2>&1; then
  echo "Installing Neovim..."
  sudo apt install -y neovim
fi

# Install tmux
if ! command -v tmux >/dev/null 2>&1; then
  echo "Installing tmux..."
  sudo apt install -y tmux
fi

# Install Astral UV (example, adjust based on actual method)
if ! command -v astral-uv >/dev/null 2>&1; then
  echo "Installing uv..."
  curl -LsSf https://astral.sh/uv/install.sh | sh
  echo 'eval "$(uv generate-shell-completion zsh)"' >> ~/.zshrc
fi

# Install nvm (Node Version Manager) and latest Node.js
if ! command -v nvm >/dev/null 2>&1; then
  echo "Installing NVM..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
  echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.zshrc
  echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.zshrc
  echo '[ -s "$NVM_DIR/bash_completion.d/nvm" ] && \. "$NVM_DIR/bash_completion.d/nvm"' >> ~/.zshrc
fi

echo "Installing latest Node.js via nvm..."
nvm install node
nvm use node

# Install pnpm
if ! command -v pnpm >/dev/null 2>&1; then
  echo "Installing pnpm..."
  curl -fsSL https://get.pnpm.io/install.sh | sh -
fi


echo ""
echo "=========================================="
echo "All done!"
echo "=========================================="
echo "Remember to:"
echo "1. Add your SSH public key to GitHub"
echo "2. Log out and back in for Zsh to become your default shell"
echo "3. Restart your terminal to activate all changes"
