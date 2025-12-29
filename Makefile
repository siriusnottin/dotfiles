CONFIG_DIR := $(HOME)/.config

.PHONY: zshenv
zshenv:
	@echo "Creating symlink for .zshenv..."
	@ln -sf $(abspath zsh/.zshenv) $(HOME)/.zshenv
	@echo "Creating symlink for .zprofile..."
	@ln -sf $(abspath zsh/.zprofile) $(HOME)/.zprofile
	@echo "Creating symlink for .profile..."
	@ln -sf $(abspath zsh/.zprofile) $(HOME)/.profile
	@echo "Creating symlink for .bash_profile..."
	@ln -sf $(abspath zsh/.zprofile) $(HOME)/.bash_profile
	@echo "Creating symlink for .bashrc..."
	@ln -sf $(abspath bash/.bashrc) $(HOME)/.bashrc
	@echo "Ensuring $(CONFIG_DIR)/zsh exists..."
	@mkdir -p $(CONFIG_DIR)/zsh

.PHONY: code
code:
	@echo "Creating symlinks for VS Code settings and keybindings..."
	@ln -sf $(abspath code/settings.json) "$(HOME)/Library/Application Support/Code/User/settings.json"
	@ln -sf $(abspath code/keybindings.json) "$(HOME)/Library/Application Support/Code/User/keybindings.json"
	@echo "VS Code settings and keybindings symlinked!"

.PHONY: stow-all
stow-all:
	@$(MAKE) zshenv
	@$(MAKE) install-bin
	@echo "Creating symlinks for all dotfiles..."
# Zsh
	@mkdir -p $(CONFIG_DIR)/zsh
	@stow -t $(CONFIG_DIR)/zsh zsh --no-folding --ignore=.zshenv
# Git
	@mkdir -p $(CONFIG_DIR)/git
	@stow -t $(CONFIG_DIR)/git git --no-folding
	@echo "Creating symlink for .gitconfig... (git/.gitconfig => ~/.gitconfig)"
	@ln -sf $(abspath git/.gitconfig) $(HOME)/.gitconfig
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
# GnuPG
	@echo "Creating symlinks for gnupg..."
	@mkdir -p $(HOME)/.gnupg
	@ln -sf $(abspath gnupg/gpg-agent.conf) $(HOME)/.gnupg/gpg-agent.conf
# VS Code
	@$(MAKE) code
	@echo "All symlinks created successfully!"

.PHONY: stow-%
stow-%:
	@case "$*" in \
		zsh) \
			echo "Creating symlinks for zsh..."; \
			mkdir -p $(CONFIG_DIR)/zsh; \
			stow -t $(CONFIG_DIR)/zsh zsh --no-folding --ignore=.zshenv; \
			;; \
		git) \
			echo "Creating symlinks for git..."; \
			mkdir -p $(CONFIG_DIR)/git; \
			stow -t $(CONFIG_DIR)/git git --no-folding; \
			echo "Creating symlink for .gitconfig... (git/.gitconfig => ~/.gitconfig)"; \
			ln -sf $(abspath git/.gitconfig) $(HOME)/.gitconfig; \
			;; \
		vim) \
			echo "Creating symlinks for vim..."; \
			echo "Creating symlink for .vim_runtime... (vim/.vimrc => ~/.vim_runtime/my_configs.vim)"; \
			ln -sf $(abspath vim/.vimrc) $(HOME)/.vim_runtime/my_configs.vim; \
			echo "Creating symlink for vim config... (vim/** => ~/.vim_runtime/...)"; \
			stow -t $(HOME)/.vim_runtime vim --no-folding --ignore=.vimrc; \
			;; \
		gnupg) \
			echo "Creating symlinks for gnupg..."; \
			mkdir -p $(HOME)/.gnupg; \
			ln -sf $(abspath gnupg/gpg-agent.conf) $(HOME)/.gnupg/gpg-agent.conf; \
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

.PHONY: list
list:
	@echo "Available dotfiles directories:"; \
	find . -maxdepth 1 -type d \( ! -name . \) -exec basename {} \; | sort

.PHONY: help
help:
	@echo "Available commands:"; \
	echo "  make stow-all       - Create symlinks for all dotfiles"; \
	echo "  make stow-<dir>     - Create symlinks for a specific directory"; \
	echo "  make clean          - Remove all symlinks"; \
	echo "  make list           - List all available dotfiles directories"; \
	echo "  make help           - Display this help message";

.PHONY: install-bin
install-bin:
	@echo "Installing ~/bin and symlinking docker wrapper..."
	@mkdir -p $(HOME)/bin
	@ln -sf $(abspath docker/docker) $(HOME)/bin/docker
	@chmod +x $(HOME)/bin/docker || true
	@echo "Installed: $(HOME)/bin/docker"
