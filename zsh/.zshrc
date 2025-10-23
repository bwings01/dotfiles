# Created by newuser for 5.9
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [[ -f "/opt/homebrew/bin/brew" ]] then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='ls --color'
alias vim='nvim'
alias c='clear'
alias print_colors='~/.config/alacritty/themes/print_colors.sh'
alias tmuxreload='tmux source ~/.config/tmux/tmux.conf'
alias zshreload='source ~/.zshrc'
alias detach='tmux detach'
alias zshconf='nvim ~/.zshrc'
alias lazy="lazygit"

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"


export PATH="$HOME/.config/.scripts:$PATH"

# ───────────────────────────────
# Zsh Syntax Highlighting — Monochrome Override
# ───────────────────────────────

# Make sure the highlighter is active
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main)

typeset -A ZSH_HIGHLIGHT_STYLES

# Commands and builtins (light gray)
ZSH_HIGHLIGHT_STYLES[command]='fg=250'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=250'
ZSH_HIGHLIGHT_STYLES[alias]='fg=250'
ZSH_HIGHLIGHT_STYLES[function]='fg=250'

# Options and arguments (medium gray)
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=244'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=244'

# Paths (underlined light gray)
ZSH_HIGHLIGHT_STYLES[path]='fg=245,underline'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=240'

# Quoted strings
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=245'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=245'

# Command separators, redirection, comments
ZSH_HIGHLIGHT_STYLES[separator]='fg=240'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=240'
ZSH_HIGHLIGHT_STYLES[comment]='fg=238'

# Unknown tokens (dim gray)
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=239,bold'

# Reserved words and defaults
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=252,bold'
ZSH_HIGHLIGHT_STYLES[default]='fg=250'

if [[ -z "$TMUX" && -z "$FASTFETCH_SHOWN" ]]; then
  export FASTFETCH_SHOWN=1
  clear
  fastfetch --pipe auto --multithreading true
  echo
fi



