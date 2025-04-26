# Vim

## Installation

### Prerequisites

Ensure you have `git` installed. If not, install it using your package manager (e.g., `sudo apt install git` on Ubuntu or `brew install git` on macOS).

Clone the repository and set up the preconfigured Vim environment:

```bash
git clone https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh
```

## Features

- Pre-configured plugins for productivity.
- Easy to customize and extend.
- Lightweight and fast.

## Usage

### Note on `.vimrc.bak`

The file `.vimrc.bak` is a backup of my previous Vim configuration file. All the configurations are now in the `~/.vim_runtime` directory. You can safely ignore this file unless you want to revert to the old configuration.

# Vim Configuration

This folder contains the Vim configuration files. The `.vimrc` file is symlinked to `~/.vim_runtime/my_configs.vim` to extend the `amix/vimrc` setup.

## Structure

- `.vimrc`: Additional configuration file for Vim.

## Notes

- The `Makefile` automates the symlink creation for compatibility with `amix/vimrc`.
- This structure ensures consistency and clarity across all dotfiles.
