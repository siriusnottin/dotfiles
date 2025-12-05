# Structure for zsh configuration

```sh
zsh-config/
├── .zshrc
├── .zshenv
├── aliases.zsh
├── functions.zsh
├── macos.zsh
└── linux.zsh
```

- `.zshrc`: Main configuration file
- `.zshenv`: Environment variables
- `aliases.zsh`: Shared aliases
- `functions.zsh`: Shared functions
- `macos.zsh`: macOS-specific configurations
- `linux.zsh`: Linux-specific configurations

# docker (wrapper for podman)

What it is:
This small script exposes a `docker` command that forwards to `podman`. It's useful for tooling (Makefiles, CI, scripts) that expect a `docker` executable but you prefer `podman`.

Install steps (recommended):
1. Put `docker` in your dotfiles: `~/os/dotfiles/zsh/docker`
2. Make it executable:
   chmod +x ~/os/dotfiles/zsh/docker
3. Option A — symlink into `~/bin` (recommended):
   mkdir -p "$HOME/bin"
   ln -sf "$HOME/os/dotfiles/zsh/docker" "$HOME/bin/docker"
   Ensure `~/bin` is early in your PATH (add to `~/.zshenv`):
     export PATH="$HOME/bin:$PATH"

   This makes `docker` available to non-interactive shells (including Make).

4. Option B — add dotfiles folder directly to PATH:
   Add to `~/.zshenv`:
     export PATH="$HOME/os/dotfiles/zsh:$PATH"

Notes:
- Put PATH changes in `~/.zshenv` so non-interactive shells (used by `make`) see them.
- If you prefer a system shim, install your platform's `podman-docker` package instead.
