#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Load shell profile
source "$HOME"/.config/shell/hwk

# Load shell scripts
source "$SHELL_DIRECTORY_CONFIG"/script/login

. "$HOME/.local/share/cargo/env"
