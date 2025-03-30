# ALIASES
alias ls="eza --color=always --icons --group-directories-first --group"

# ENVIRONMENT VARIABLES
typeset -U PATH # avoid duplicates in PATH variable
path=( 
  $path
  $HOME/.local/bin
)

export PATH
export HISTFILE=~/.zsh_history
export HISTSIZE=10000  # how many commands zsh will load to memory
export SAVEHIST=10000  # how many commands history will save on file
export WORDCHARS=${WORDCHARS:s:/:} # do not consider this chars as part of a word

# HISTORY SETTINGS
setopt HIST_IGNORE_ALL_DUPS  # history won't save duplicates
setopt HIST_FIND_NO_DUPS  # history won't show duplicates on search

# KEY BINDINGS
bindkey '^[[1;5C' emacs-forward-word   # move to the end of the next word
bindkey '^[[1;5D' backward-word  # move to the begining of the current word

# TAB COMPLETION
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*' # case insensitive completion
zstyle ':completion:*:(cd|pushd):*' list-colors ${(s.:.)LS_COLORS}

# PROMPT
autoload -U colors && colors
# PS1="%{$fg[green]%}[%n@%m]%~%% %{$reset_color%}"
PS1="%{$fg[green]%}[%n@%m]%{$fg[blue]%}%~%{$fg[white]%}\$ %{$reset_color%}"

# ZSH-SYNTAX-HIGHLIGHTING SETTINGS
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=green,underline'
ZSH_HIGHLIGHT_STYLES[arg0]='fg=green'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=green,underline'
ZSH_HIGHLIGHT_STYLES[autodirectory]='fg=green,underline'
ZSH_HIGHLIGHT_STYLES[path]='fg=white,underline'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=none' 
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=none' 
ZSH_HIGHLIGHT_STYLES[default]='fg=none' 

# ANTIDOTE PLUGIN MANAGER
source /usr/share/zsh-antidote/antidote.zsh
antidote load

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# Load Angular CLI autocompletion.
source <(ng completion script)
