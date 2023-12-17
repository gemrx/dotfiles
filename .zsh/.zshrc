# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# --------> GENERAL <--------
export PATH=$HOME/bin:/usr/local/bin:$PATH
export ZSH=$HOME/.zsh
export WORDCHARS=${WORDCHARS:s:/:} # do not consider this chars as part of the word

# --------> HISTORY CONFIG <--------
export HISTFILE=~/.zsh_history
export HISTSIZE=10000  # how many commands zsh will load to memory
export SAVEHIST=10000  # how many commands history will save on file
setopt HIST_IGNORE_ALL_DUPS  # history won't save duplicates
setopt HIST_FIND_NO_DUPS  # history won't show duplicates on search

# --------> KEYBINDINGS  <--------
bindkey '^[[1;5C' forward-word   # Ctrl+Right
bindkey '^[[1;5D' backward-word  # Ctrl+Left

# --------> CASE INSENSITIVE <--------
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
autoload -Uz compinit && compinit

# Enable tab completion for dnf command
autoload -Uz compinit && compinit
zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*:cd:*' menu yes select
zstyle ':completion:*:(cd|pushd):*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:(cd|pushd):*' group-order local-directories directory-stack path-directories
zstyle ':completion:*:(cd|pushd):*' verbose yes
zstyle ':completion:*:(cd|pushd):*' list-colors ${(s.:.)LS_COLORS}
compctl -k "((${(f)${(M)${(s: :)BUFFER}:#dnf*}:#*install*} --packages -q))" dnf

# --------> ALIASES <--------
source $ZSH/aliases.zsh

# --------> THEMES <--------
# source $ZSH/themes/powerlevel10k/powerlevel10k.zsh-theme

# --------> PLUGINS <--------
source $ZSH/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#source $ZSH/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Compinit to check .zcompdump cache once a day
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

# --------> NVM <--------
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # this loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# --------> FZF <--------
export FZF_DEFAULT_COMMAND="fd --hidden --follow"  # override fzf default command to use fd
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND" # CTRL-T's command
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND --type d" # ALT-C's command

_fzf_compgen_path() {
    fd . "$1"
}
_fzf_compgen_dir() {
    fd --type d . "$1"
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh # source fzf
