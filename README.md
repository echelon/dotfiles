# dotfiles

One repo for everything, managed with [chezmoi](https://chezmoi.io).
Works on macOS and Linux. Replaces the old per-software `dotfile/*` repos
and most of `bootstrap-machine`.

## Layout

```
home/                       chezmoi source state (via .chezmoiroot)
  dot_zshrc                 zsh (primary shell on macOS)
  dot_bashrc                bash (primary shell on Linux)
  dot_gitconfig.tmpl        git
  private_dot_config/
    shell/                  env + aliases shared by both shells
      aliases/            10-tools, 20-shortcuts, 30-typos (typo fixes only)
    tmux/tmux.conf          tmux
    nvim/                   neovim (kickstart.nvim-based, lazy.nvim)
    packages/               Brewfile (macOS) + apt.txt (Linux)
  run_onchange_install-packages.sh.tmpl
                            installs packages when the lists change
docs/                       non-dotfile setup notes (macOS settings, apps, ...)
```

## New machine

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply echelon/dotfiles
```

That installs chezmoi, clones this repo, symlinks nothing — chezmoi *copies*
rendered files into place — and runs the package-install script.

## Daily use

```sh
chezmoi edit ~/.zshrc     # edit the source, not the live file
chezmoi diff              # see what would change
chezmoi apply             # make it so
chezmoi cd                # jump to this repo
```

Or edit files here directly and `chezmoi apply`. On this machine the source
dir is `~/dev/echelon/dotfiles` (set in `~/.config/chezmoi/chezmoi.toml`).

Package changes: edit `home/private_dot_config/packages/Brewfile` or `apt.txt`, then
`chezmoi apply` re-runs the installer (the script hashes the lists).

## Neovim

`home/private_dot_config/nvim` started life as
[kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) — a single
heavily-commented `init.lua`. Personal tweaks live at the bottom of
`init.lua`; read the comments, it's meant to be understood and owned.

Vim's registers and the system clipboard are independent (`clipboard=`), as in
vanilla Vim. Ordinary `yy`, `dd`, `x`, and `c` use Vim's registers; `p`/`P` paste
from those registers. Terminal copy/paste shortcuts continue to use the system
clipboard (Command+C/V on macOS). Copy uses the terminal's selection, which is
separate from Vim's Visual selection. Ctrl+C/V/X retain their Vim meanings.

The `"+` register remains available for explicit system clipboard access.
Restart Neovim after applying config changes.
