export PATH="$HOME/.local/bin:$PATH"
export PATH=$PATH:/usr/local/bin

# zsh 
autoload -U compinit; compinit # completions
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
HIST_STAMPS="yyyy-mm-dd"
setopt appendhistory
setopt EXTENDED_HISTORY          # Write timestamps to history
setopt INC_APPEND_HISTORY        # Write immediately, not on shell exit
setopt SHARE_HISTORY             # Share history between all sessions
setopt HIST_IGNORE_DUPS          # Don't record duplicate commands
setopt HIST_IGNORE_ALL_DUPS      # Delete old duplicates
setopt HIST_IGNORE_SPACE         # Don't record commands starting with space
setopt HIST_SAVE_NO_DUPS         # Don't write duplicates to file
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks
setopt HIST_VERIFY               # Don't execute immediately on history expansion
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
bindkey '^[OA' history-search-backward
bindkey '^[OB' history-search-forward
bindkey "^[[1;5C" forward-word # CTRL arrow left
bindkey "^[[1;5D" backward-word # CTRL arrow right 

# oh my posh
export ZSH="$HOME/.oh-my-zsh"
eval "$(oh-my-posh init zsh)"

# uv
eval "$(uv generate-shell-completion zsh)"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion.d/nvm" ] && \. "$NVM_DIR/bash_completion.d/nvm"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"

eval "$(uv generate-shell-completion zsh)"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion.d/nvm" ] && \. "$NVM_DIR/bash_completion.d/nvm"
