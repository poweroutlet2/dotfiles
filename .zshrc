# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH="$HOME/.local/bin:$PATH"
export PATH=$PATH:/usr/local/bin

# zsh 
export ZDOTDIR="${ZDOTDIR:-$HOME}"
export HISTFILE="$ZDOTDIR/.zsh_history"
export HISTSIZE=100000
export SAVEHIST=100000
setopt inc_append_history share_history extended_history hist_ignore_all_dups hist_reduce_blanks
setopt autocd correct nocaseglob interactivecomments

# cached completions
autoload -Uz compinit
zmodload zsh/complist
if [[ ! -f "$ZDOTDIR/.zcompdump" || "$HOME/.zshrc" -nt "$ZDOTDIR/.zcompdump" ]]; then
compinit -i
else
compinit -C
fi


command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh)"


# Antidote setup
if [[ ! -d "$HOME/.antidote" ]]; then
git clone --depth=1 https://github.com/mattmc3/antidote "$HOME/.antidote" >/dev/null 2>&1
fi
source "$HOME/.antidote/antidote.zsh"

# Antidote plugins setup
ZPLUG="$ZDOTDIR/.zsh_plugins.txt"
if [[ ! -f "$ZPLUG" ]]; then
cat >"$ZPLUG" <<'PLUGS'
zsh-users/zsh-completions
zsh-users/zsh-autosuggestions
zsh-users/zsh-history-substring-search
Aloxaf/fzf-tab
zsh-users/zsh-syntax-highlighting
PLUGS
fi

# Antidote load plugins
antidote load "$ZPLUG"

zstyle ':completion:' menu select
zstyle ':fzf-tab:' switch-group ',' '.'


# Keybindings
bindkey -e
bindkey "^[[1;5C" forward-word # CTRL arrow left
bindkey "^[[1;5D" backward-word # CTRL arrow right

# History substring search keybindings
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down 


## Tools setup  stuff
# uv
eval "$(uv generate-shell-completion zsh)"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion.d/nvm" ] && \. "$NVM_DIR/bash_completion.d/nvm"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# bun completions
[ -s "/home/harsh/.bun/_bun" ] && source "/home/harsh/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
