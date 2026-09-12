# Modern replacements for classic tools. Each alias only activates if the tool
# is installed, so this file is safe on a bare machine.

# --- ls / cat / find / grep / du / top / diff ---------------------------------
if have eza; then
  alias ls='eza --group-directories-first'
  alias ll='eza -l --group-directories-first --git'
  alias la='eza -la --group-directories-first --git'
  alias tree='eza --tree'
else
  alias ll='ls -lh'
  alias la='ls -lha'
fi

have bat && alias cat='bat --paging=never'
have batcat && alias bat='batcat' && alias cat='batcat --paging=never'  # Debian/Ubuntu name
have fdfind && alias fd='fdfind'                                       # Debian/Ubuntu name
have rg && alias grep-r='rg'
have dust && alias du='dust'
have btop && alias top='btop'
have delta && alias diff='delta'

# --- Editor -----------------------------------------------------------------
if have nvim; then
  alias vi='nvim -p'   # -p: open multiple files in tabs (old habit, still good)
  alias vim='nvim'
else
  alias vi='vi -p'
fi
