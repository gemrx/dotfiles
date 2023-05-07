# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# --------> EXPORTS <--------
export PATH=$HOME/bin:/usr/local/bin:$PATH
export ZSH=$HOME/.zsh

# --------> HISTORY CONFIG <--------
export HISTFILE=$ZSH/.zsh_history
export HISTSIZE=10000  # How many commands zsh will load to memory
export SAVEHIST=10000  # How many commands history will save on file
setopt HIST_IGNORE_ALL_DUPS  # History won't save duplicates
setopt HIST_FIND_NO_DUPS  # History won't show duplicates on search

# --------> KEYBINDINGS  <--------
bindkey '^[[1;5C' forward-word   # Ctrl+Right
bindkey '^[[1;5D' backward-word  # Ctrl+Left

# --------> CASE INSENSITIVE <--------
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
autoload -Uz compinit && compinit

# --------> ALIASES <--------
source $ZSH/aliases.zsh

# --------> THEMES <--------
source $ZSH/themes/powerlevel10k/powerlevel10k.zsh-theme

# --------> PLUGINS <--------
source $ZSH/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
