export ZDOTDIR=$HOME/.config/zsh

# Ensure user-local bin is early in PATH so shims (like our docker wrapper) are found
export PATH="$HOME/bin:$PATH"
