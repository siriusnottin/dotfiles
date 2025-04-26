CONFIG_DIR := $(HOME)/.config

.PHONY: zshenv
zshenv:
	@echo "Creating symlink for .zshenv..."
	@ln -sf $(abspath zsh/.zshenv) $(HOME)/.zshenv

.PHONY: stow-all
stow-all:
	@$(MAKE) zshenv
	@echo "Creating symlinks for all dotfiles..."
# Zsh
	@mkdir -p $(CONFIG_DIR)/zsh
	@stow -t $(CONFIG_DIR)/zsh zsh --no-folding --ignore=.zshenv
# Git
	@mkdir -p $(CONFIG_DIR)/git
	@stow -t $(CONFIG_DIR)/git git --no-folding
# Tmux
	@mkdir -p $(CONFIG_DIR)/tmux
	@stow -t $(CONFIG_DIR)/tmux tmux --no-folding
# Vim
	@echo "Creating symlink for .vim_runtime... (vim/.vimrc => ~/.vim_runtime/my_configs.vim)"
	@ln -sf $(abspath vim/.vimrc) $(HOME)/.vim_runtime/my_configs.vim
	@echo "Creating symlink for vim config... (vim/** => ~/.vim_runtime/...)"
	@stow -t $(HOME)/.vim_runtime vim --no-folding --ignore=.vimrc
# Ghostty
	@mkdir -p $(CONFIG_DIR)/ghostty
	@stow -t $(CONFIG_DIR)/ghostty ghostty --no-folding
	@echo "All symlinks created successfully!"

.PHONY: stow-%
stow-%:
	@case "$*" in \
		zsh) \
			echo "Creating symlinks for zsh..."; \
			mkdir -p $(CONFIG_DIR)/zsh; \
			stow -t $(CONFIG_DIR)/zsh zsh --no-folding --ignore=.zshenv; \
			;; \
		*) \
			echo "Creating symlinks for $*..."; \
			mkdir -p $(CONFIG_DIR)/$*; \
			stow -t $(CONFIG_DIR)/$* $* --no-folding; \
			;; \
	esac

.PHONY: clean
clean:
	@echo "Removing all symlinks..."
	@stow -D -t $(CONFIG_DIR) *
	@echo "Removing .zshenv..."
	@rm -f $(HOME)/.zshenv
