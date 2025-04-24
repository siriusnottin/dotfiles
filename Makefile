.PHONY: stow-all
stow-all:
	@echo "Creating symlinks for all dotfiles..."
	@stow -t $$HOME zsh
	@stow -t $$HOME git
	@stow -t $$HOME tmux
	@stow -t $$HOME --ignore=".vim_runtime" vim
	@stow -t $$HOME vim/.vim_runtime
	@echo "All symlinks created successfully!"

.PHONY: clean
clean:
	@echo "Removing all symlinks..."
	@stow -D -t $$HOME zsh vim git tmux
	@echo "All symlinks removed!"
