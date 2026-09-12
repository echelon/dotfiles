# Shared aliases for zsh and bash. This file is only a loader: the actual
# aliases live in ~/.config/shell/aliases/, one file per concern, sourced in
# name order. Add a new file there rather than growing this one.
#
#   10-tools.sh      modern replacements for classic tools (eza, bat, ...)
#   20-shortcuts.sh  shorter names for commands you type all day
#   30-typos.sh      typo correction only (celar -> clear, gti -> git, ...)

# Helper used by the alias files: `have cmd` is true if cmd is installed.
have() { command -v "$1" >/dev/null 2>&1; }

for _f in "$HOME/.config/shell/aliases"/*.sh; do
  [ -r "$_f" ] && . "$_f"
done
unset _f
