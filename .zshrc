# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Enviroment variables
export PATH="$HOME/.local/bin:$PATH"
export ZSH=$HOME/.config/zsh
export HISTFILE=~/.zsh_history
export HISTSIZE=10000  # how many commands zsh will load to memory
export SAVEHIST=10000  # how many commands history will save on file
export WORDCHARS=${WORDCHARS:s:/:} # do not consider this chars as part of a word

# Aliases
source $ZSH/aliases.zsh

# History settings
setopt HIST_IGNORE_ALL_DUPS  # history won't save duplicates
setopt HIST_FIND_NO_DUPS  # history won't show duplicates on search

# Key bindings
bindkey '^[[1;5C' emacs-forward-word   # move to the end of the next word
bindkey '^[[1;5D' backward-word  # move to the begining of the current word

# Auto completion
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*' # case insensitive completion
zstyle ':completion:*:(cd|pushd):*' list-colors ${(s.:.)LS_COLORS}

# Plugins
source $ZSH/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSH/plugins/powerlevel10k/powerlevel10k.zsh-theme

# zsh-syntax-highlighting settings
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=green,underline'
ZSH_HIGHLIGHT_STYLES[arg0]='fg=green'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=green,underline'
ZSH_HIGHLIGHT_STYLES[autodirectory]='fg=green,underline'
ZSH_HIGHLIGHT_STYLES[path]='fg=none,underline'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=none' 
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=none' 
ZSH_HIGHLIGHT_STYLES[default]='fg=none' 

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f $ZSH/.p10k.zsh ]] || source $ZSH/.p10k.zsh

# Node version manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion 
