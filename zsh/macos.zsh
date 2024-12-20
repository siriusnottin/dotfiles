### ZNAP
# Download Znap, if it's not there yet.
[[ -f ~/.zsh-plugins/zsh-snap/znap.zsh ]] ||
  git clone --depth 1 -- \
    https://github.com/marlonrichert/zsh-snap.git ~/.zsh-plugins/zsh-snap

# Start Znap
source ~/.zsh-plugins/zsh-snap/znap.zsh
###

znap source ohmyzsh/ohmyzsh

if [[ $TERM_PROGRAM == "WarpTerminal" ]]; then
  SPACESHIP_PROMPT_ASYNC=FALSE
fi

znap prompt spaceship-prompt/spaceship-prompt

# Custom RPROMPT segment for spaceship-prompt
spaceship_custom_project_root() {
  local root_folder=$(get_project_root)
  [[ -n $root_folder ]] && echo "$root_folder"
}

# Add custom segment to RPROMPT
# SPACESHIP_RPROMPT_ORDER=(
#   custom_project_root
# )

znap source zsh-users/zsh-completions
znap source zsh-users/zsh-autosuggestions

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
znap source zsh-users/zsh-syntax-highlighting

znap source supercrabtree/k

omz_plugins=(
  "git"
  "npm"
  macos
)

for plugin in ${omz_plugins[@]}; do
  znap source ohmyzsh/ohmyzsh plugins/$plugin
done

export FZF_BASE=~[ohmyzsh/ohmyzsh]/plugins/fzf

znap eval brew-shellenv 'brew shellenv'

# https://github.com/roots/trellis-cli#virtualenv
# znap eval trellis 'trellis shell-init zsh'

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
znap function _pyenv pyenv 'eval "$( pyenv init - --no-rehash )"'
compctl -K _pyenv pyenv
znap eval pip-completion 'pip completion --zsh'

# NVM
export NVM_COMPLETION=true
# export NVM_LAZY_LOAD=true
znap source lukechilds/zsh-nvm

if [[ $TERM_PROGRAM != "WarpTerminal" ]]; then
  export ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX=YES
  znap eval iterm2 'curl -fsSL https://iterm2.com/shell_integration/zsh'
fi

export GPG_TTY=$(tty)

export NVM_DIR="$HOME/.nvm"
nvm_lazy_load() {
  unset -f nvm node npm npx
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
}

nvm() {
  nvm_lazy_load
  command nvm "$@"
}

node() {
  nvm_lazy_load
  command node "$@"
}

npm() {
  nvm_lazy_load
  command npm "$@"
}

npx() {
  nvm_lazy_load
  command npx "$@"
}

compdef _nvm nvm

# eval "$(op completion zsh)"
# compdef _op op

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

# Home Assistant CLI
# eval "$(_HASS_CLI_COMPLETE=source_zsh hass-cli)"

alias sed=gsed # use gnu-sed instead of the mac osx sed

# export EDITOR="code --wait"
# alias codi="code-insiders"
# set -o vim
export EDITOR="vim"
# GitHub
alias gho="gh repo view -w" #TODO: make sure gh is installed
# TODO: add github command to copy repo URL directly in the clipboard

# =================== Spotify ===============================
# Spotify is supported using the OMZSH MacOS plugin. (using the official Spotify API)
# Raycast is also using the official API.

# do not register commands preceded by a space
export HISTCONTROL=ignorespace

znap eval broot 'source ${HOME}/.config/broot/launcher/bash/br'
