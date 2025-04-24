# Define the directories to be managed by Stow
DOTFILES := zsh git tmux vim

# Default target to add a new dotfile
.PHONY: add
add:
	@echo "Usage: make add DOTFILE=<dotfile>"
	@echo "Example: make add DOTFILE=zsh"

# Target to symlink the specified dotfile
.PHONY: add-dotfile
add-dotfile:
	@stow $(DOTFILE)

# Target to symlink all dotfiles using Stow
.PHONY: stow
stow:
	@for dir in $(DOTFILES); do \
		stow -t $$HOME $$dir; \
	done

# Add a new dotfile and symlink it using Stow
<dotfile>:
	stow <dotfile>

# Remove all symlinks created by Stow
.PHONY: clean
clean:
	stow -D *

# List all available dotfiles
.PHONY: list
list:
	@stow --no --verbose=2 | grep 'LINK:' | awk '{print $$2}'
