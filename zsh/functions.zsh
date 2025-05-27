# Create a folder and move into it in one command
function mkcd() { mkdir -p "$@" && cd "$_"; }

# create a folder, move into it, initialize git and create a README.md and open it in vscode
# TODO: Create simple cli to improve new project creation (os new project --name "My Super Project", --type "app|labs|learn|hesias course b1"  --git-plateform "GitHub|Gitlab|Gitea")
# TODO: Implement addtion of git workflow
function mkcdg() {
  mkcd "$@"
  git init
  touch README.md
}

# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
    -o -type d -print 2>/dev/null | fzf +m) &&
    cd "$dir"
}

# fh - search in your command history and execute selected command
# TODO: test this
fh() {
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

# TODO: Test this fn
function forget() {
  history -d $(history | awk 'END{print $1-1}')
}

# Function to get the root folder if in ~/Projects
get_project_root() {
  local dir="$PWD"
  while [[ "$dir" != "/" && "$dir" != "$HOME" ]]; do
    if [[ "$dir" == "$HOME/Projects"* ]]; then
      echo "${dir#$HOME/Projects/}" | cut -d'/' -f1
      return
    fi
    dir=$(dirname "$dir")
  done
}

pyenv-brew-relink() {
  rm -f "${HOME}/.pyenv/versions/*-brew"

  for i in $(brew --cellar)/python@*; do
    for p in $i/*; do
      echo $p
      ln -sf $p ${HOME}/.pyenv/versions/${p##/*/}-brew
      # Link the pip executable
      if [[ -x "$p/bin/pip" ]]; then
        ln -sf "$p/bin/pip" "${HOME}/.pyenv/versions/${p##/*/}-brew/bin/pip"
      fi
    done
  done
  pyenv rehash
}

# Expand aliases when pressing space
expand-alias() {
  zle _expand_alias
  zle self-insert
}
zle -N expand-alias
bindkey ' ' expand-alias

# Shared message to display before pull/rebase/fetch
# Displays a safety message with guidelines for using git pull, rebase, and fetch
display_git_safety_message() {
  echo -e "\033[1;33m[WARNING]\033[0m"
  echo -e "- Use git pull when you're working on a shared branch."
  echo -e "  It helps incorporate the latest changes without modifying the commit history extensively."
  echo -e "- Use git rebase when you're working on a feature branch and want a clean history."
  echo -e "  This approach is suitable for local branches that are not yet shared."
}

# Override the default git command to display safety messages for pull, rebase, and fetch.
# Use 'command git' to bypass this override and access the default git behavior.
git_override() {
  case "$1" in
    pull|rebase|fetch)
      display_git_safety_message
      ;;
  esac
  command git "$@"
}
alias git='git_override'
