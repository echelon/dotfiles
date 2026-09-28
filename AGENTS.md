# AGENTS.md

Guidance for AI coding agents working in this repo. `CLAUDE.md` is a symlink
to this file.

## What this is

Personal dotfiles for macOS and Linux (Ubuntu), managed with
[chezmoi](https://chezmoi.io). chezmoi **copies** rendered files into `$HOME`;
nothing is symlinked. On the primary machine the source dir is
`~/dev/echelon/dotfiles` (configured in `~/.config/chezmoi/chezmoi.toml`).

## Layout

`.chezmoiroot` contains `home`, so only `home/` is chezmoi source state. Files
at the repo root (`README.md`, `AGENTS.md`, `docs/`) are never deployed.

```
home/
  dot_zshrc                        ~/.zshrc   (primary shell on macOS)
  dot_bashrc                       ~/.bashrc  (primary shell on Linux)
  dot_bash_profile                 ~/.bash_profile (just sources .bashrc)
  dot_gitconfig.tmpl               ~/.gitconfig (templated)
  private_dot_config/              ~/.config (mode 0700)
    shell/env.sh                   env/PATH shared by zsh and bash
    shell/aliases.sh               loader; sources shell/aliases/*.sh in order
    shell/aliases/10-tools.sh      modern tool replacements (eza, bat, ...)
    shell/aliases/20-shortcuts.sh  keystroke-saving shortcuts
    shell/aliases/30-typos.sh      typo corrections ONLY
    starship.toml                  prompt
    tmux/tmux.conf                 tmux (plugins via tpm)
    nvim/                          Neovim, based on kickstart.nvim
    packages/Brewfile              macOS packages
    packages/apt.txt               Linux packages
  run_onchange_before_install-packages.sh.tmpl
                                   package installer (see below)
docs/                              manual setup notes chezmoi can't automate
```

## chezmoi naming conventions

Source filenames encode target attributes; keep them when adding files:

- `dot_foo` → `.foo`
- `private_` → target gets 0700/0600 permissions
- `.tmpl` suffix → rendered as a Go template (`{{ .chezmoi.os }}`,
  `lookPath`, `output`, `semverCompare`, etc.)
- `run_onchange_before_*` → script runs before applying files, and re-runs
  whenever its rendered content changes

To add a new dotfile, create it under `home/` with the right prefixes (or run
`chezmoi add ~/.whatever`, which does the naming for you).

## How things fit together

- **Shells.** Both `dot_zshrc` and `dot_bashrc` source
  `~/.config/shell/env.sh` then `~/.config/shell/aliases.sh`. Anything that
  should work in both shells goes in `shell/`; shell-specific settings
  (history, completion, vi mode, tool init hooks) stay in the rc files. Keep
  shared shell files POSIX-ish so they work in both bash and zsh.
- **Aliases.** `aliases.sh` defines a `have cmd` helper and sources
  `aliases/*.sh` in name order. Respect each file's scope:
  - `10-tools.sh`: replacements that activate only if the tool is installed
    (guard with `have`), so a bare machine still works.
  - `20-shortcuts.sh`: shorter names only; never change a command's behavior.
  - `30-typos.sh`: misspelling → intended command only.
  - For a new concern, add a new numbered file rather than growing an existing
    one.
  - zsh deliberately hides aliases from command completion (`tag-order
    '! aliases'`) so typo aliases don't show up as completions.
- **Optional tools.** Tool hooks (zoxide, fzf, starship, delta) are guarded
  with `command -v` / `lookPath` so configs degrade gracefully when a tool is
  missing. Follow the same pattern.
- **Packages.** `run_onchange_before_install-packages.sh.tmpl` embeds sha256
  hashes of `Brewfile` and `apt.txt` in comments, so editing either list
  changes the rendered script and chezmoi re-runs it on the next
  `chezmoi apply`. On macOS it runs `brew bundle`; on Linux it `apt-get
  install`s only packages that have an apt candidate (skipping unknown ones
  instead of failing). It also bootstraps tpm into
  `~/.config/tmux/plugins/tpm`.
- **Git config.** `dot_gitconfig.tmpl` picks `zdiff3` vs `diff3` based on the
  installed git version (Ubuntu 22.04 ships git < 2.35), and only configures
  delta as the pager if delta is on PATH.
- **Neovim.** `nvim/` is a kickstart.nvim fork using lazy.nvim. It is mostly a
  single heavily commented `init.lua`; personal tweaks live at the bottom of
  it. Extra plugin specs can go in `lua/custom/plugins/*.lua`. Lua is
  formatted with StyLua (`.stylua.toml`). The clipboard is intentionally
  decoupled from Vim registers (`clipboard=`); don't reintroduce
  `unnamedplus`.

## Working in this repo

- Edit the source files here, not the deployed files in `$HOME`.
- Preview and apply:
  ```sh
  chezmoi diff     # what would change in $HOME
  chezmoi apply    # deploy (also runs the installer if package lists changed)
  ```
- Check a template renders: `chezmoi execute-template < home/dot_gitconfig.tmpl`
  or `chezmoi cat ~/.gitconfig`.
- Don't run `chezmoi apply` or install packages without the user's go-ahead;
  it modifies the live home directory.
- Everything must work on both macOS (zsh, Homebrew at `/opt/homebrew`) and
  Linux (bash, apt, Debian package names like `batcat`/`fdfind`). Use
  `{{ if eq .chezmoi.os "darwin" }}` in templates, or runtime checks in shell
  files, for platform differences.
- Match the existing style: short header comment explaining each file's
  purpose, section dividers (`# --- Name ---`), and brief inline comments
  explaining *why*.
- Update `README.md` when changing layout or workflow.
