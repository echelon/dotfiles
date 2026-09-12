# Shorter names for commands typed all day. Nothing here changes what a
# command does; it only saves keystrokes. Typo fixes belong in 30-typos.sh.

# --- Editor -----------------------------------------------------------------
alias v='vi'

# --- Navigation ---------------------------------------------------------------
alias cdd='cd ~/dev'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias -- -='cd -'

# --- Git ----------------------------------------------------------------------
alias g='git'
alias gs='git status'
alias gd='git diff'
alias gds='git diff --staged'
alias ga='git add'
alias gaa='git add -A'
alias gc='git commit'
alias gcm='git commit -m'
alias gco='git checkout'
alias gb='git branch'
alias gp='git push'
alias gpl='git pull'
alias gf='git fetch --prune'
alias gl='git log --oneline --graph --decorate -20'
alias branch='git branch'
alias checkout='git checkout'

# --- Files ------------------------------------------------------------------
alias md='mkdir -p'
alias cp='cp -i'      # ask before clobbering
alias mv='mv -i'
alias h='history'

# --- Misc -------------------------------------------------------------------
alias c='clear'
alias sighup='kill -HUP'
alias path='echo "$PATH" | tr ":" "\n"'
# agent-notify-server: silence any playing notification sound.
alias stop-sound='curl -fsS -m 1 http://127.0.0.1:43110/stop -o /dev/null'
