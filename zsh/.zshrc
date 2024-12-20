# Source shared configurations
source ~/os/dotfiles/zsh/aliases.zsh
source ~/os/dotfiles/zsh/functions.zsh

# Source OS-specific configurations
if [[ "$OSTYPE" == darwin* ]]; then
  source ~/os/dotfiles/zsh/macos.zsh
elif [[ "$OSTYPE" == linux* ]]; then
  source ~/os/dotfiles/zsh/linux.zsh
fi

# detect on which system we are running on (ubuntu or macos)
# if [[ -f /etc/os-release ]]; then
#   source /etc/os-release
#   OS=$ID # ubuntu
# elif [[ -f /usr/bin/sw_vers ]]; then
#   OS="macos"
# fi
