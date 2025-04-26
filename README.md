# dotfiles

List of my dotfiles and configurations.

[Stow](https://www.gnu.org/software/stow/) is used to help with symlink management.

## Instructions

When adding a new dotfile, make sure to add it to the appropriate directory and run `stow <directory>` to symlink it to the correct location.

From time to time, I will add new dotfiles to this repo.

My process is like this:

```bash
pwd # output: dotfiles/
git checkout -b feat/add-<dotfile> main
make <dotfile>
```

## Makefile Usage

The Makefile is used to automate the process of managing dotfiles. Here are some common commands:

- `make <dotfile>`: Add a new dotfile and symlink it using Stow.
- `make clean`: Remove all symlinks created by Stow.
- `make list`: List all available dotfiles.
- `make help`: Display help information for the Makefile.
- `make install`: Install all dotfiles by running `stow` on each directory.

## Znap

Znap is a fast Zsh plugin manager that can significantly speed up your shell startup time by compiling your Zsh scripts. It is designed to be simple and efficient, making it a great choice for managing your Zsh plugins and configurations.

### Why Znap?

- **Speed**: Znap compiles your Zsh scripts, which can greatly reduce the time it takes for your shell to start.
- **Simplicity**: Znap is easy to use and configure, making it accessible for users of all levels.
- **Efficiency**: By managing your plugins and configurations with Znap, you can keep your `.zshrc` clean and organized.

For more information, visit the [Znap GitHub repository](https://github.com/marlonrichert/zsh-snap).

Go to [issues](https://github.com/siriusnottin/dotfiles/issues) for the list of dotfiles I plan to add.

This repo is part of my [os](https://github.com/siriusnottin/os) project, which is a cli to help me, as the title says, manage my os. It is a work in progress and I will be adding more features as I go along.

> [!NOTE]
> **Note for later**
> This website could be a great resource for my dotfiles management: [https://dotfiles.github.io/](https://dotfiles.github.io/)
