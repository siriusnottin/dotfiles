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
mv ~/<dotfile> ./
stow .
```

Go to [issues](https://github.com/siriusnottin/dotfiles/issues) for the list of dotfiles I plan to add.

This repo is part of my [os](https://github.com/siriusnottin/os) project, which is a cli to help me, as the title says, manage my os. It is a work in progress and I will be adding more features as I go along.
