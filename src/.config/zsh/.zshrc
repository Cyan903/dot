#
# ~/.zshrc
# ~/.config/zsh/.zshrc
#
# Assuming ~/dot:
#   $ cd ~/dot/src
#   $ ln -sf .config/zsh/.zshrc .zshrc
#

# Load shell profile
source "$HOME"/.config/sh/hwk

# Load shell scripts
source "$SHELL_DIRECTORY_CONFIG"/script/welcome

# Ensure vi mode is disabled when using neovim
# https://apple.stackexchange.com/a/326623
[[ -n $ZSH_VI_DISABLED ]] && EDITOR="nano"

# Set history
export ZDOTDIR="$XDG_CONFIG_HOME"/zsh

HISTFILE=~/.cache/zhistfile
HISTSIZE=1000
SAVEHIST=1000

# Keybinds
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

bindkey "^[[1;5C" forward-word # ctrl + ->
bindkey "^[[1;5D" backward-word # ctrl + <-
bindkey -s "^[y" "y^M" # alt + y

# Tab completions
autoload -U compinit
zstyle ":completion:*" menu select
zmodload zsh/complist

compinit
_comp_options+=(globdots)

# Zoxide
eval "$(zoxide init zsh)"
alias cd="z"

# direnv
eval "$(direnv hook zsh)"

# Prompt
setopt promptsubst
autoload -U colors && colors
source "$SHELL_DIRECTORY_CONFIG"/prompt/zsh

# Plugins
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-history-substring-search"
plug "zsh-users/zsh-syntax-highlighting"
plug "MichaelAquilina/zsh-you-should-use"

[[ -z $ZSH_VI_DISABLED ]] && plug "jeffreytse/zsh-vi-mode"

