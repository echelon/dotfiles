# Shared aliases for zsh and bash. Modern tools are opt-in: each alias only
# activates if the tool is installed, so this file is safe on a bare machine.

have() { command -v "$1" >/dev/null 2>&1; }

# --- Modern replacements for classic tools ---------------------------------
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
alias v='vi'

# --- Navigation ---------------------------------------------------------------
alias cdd='cd ~/dev'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# --- Git ----------------------------------------------------------------------
alias g='git'
alias gs='git status'
alias gd='git diff'
alias gl='git log --oneline --graph --decorate -20'
alias branch='git branch'
alias checkout='git checkout'

# --- Typo forgiveness -----------------------------------------------------------
alias celar='clear'
alias claer='clear'
alias clea='clear'
alias clera='clear'
alias sl='ls'

# --- Misc -------------------------------------------------------------------
alias sighup='kill -HUP'
# agent-notify-server: silence any playing notification sound.
alias stop-sound='curl -fsS -m 1 http://127.0.0.1:43110/stop -o /dev/null'
