# Enviroment Variables
export PATH=$HOME/bin:/usr/local/bin:$PATH
export ZSH=$HOME/.zsh
export WORDCHARS=${WORDCHARS:s:/:} # do not consider this chars as part of the word

# Aliases
source $ZSH/aliases.zsh

# History Settings
export HISTFILE=~/.zsh_history
export HISTSIZE=10000  # how many commands zsh will load to memory
export SAVEHIST=10000  # how many commands history will save on file
setopt HIST_IGNORE_ALL_DUPS  # history won't save duplicates
setopt HIST_FIND_NO_DUPS  # history won't show duplicates on search

# Key Bindings
bindkey '^[[1;5C' emacs-forward-word   # move to the end of the next word
bindkey '^[[1;5D' backward-word  # move to the begining of the current word

# Completion Settings
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*' # case insensitive completion
zstyle ':completion:*:(cd|pushd):*' list-colors ${(s.:.)LS_COLORS}

# Plugins
source $ZSH/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# zsh-syntax-highlighting settings
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]='fg=cyan,underline'

# --------> NVM <--------
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # this loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# --------> FZF <--------
# export FZF_DEFAULT_COMMAND="fd --hidden --follow"  # override fzf default command to use fd
# export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND" # CTRL-T's command
# export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND --type d" # ALT-C's command

# _fzf_compgen_path() {
#     fd . "$1"
# }
# _fzf_compgen_dir() {
#     fd --type d . "$1"
# }

# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh # source fzf
