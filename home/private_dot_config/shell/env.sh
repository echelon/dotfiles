# Shared environment for zsh and bash. Sourced early by both rc files.

export EDITOR=nvim
export VISUAL=nvim

export PATH="$HOME/.local/bin:$PATH"

# Homebrew (Apple Silicon path; harmless elsewhere)
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  export PATH="/opt/homebrew/opt/mysql@8.4/bin:$PATH"
fi

# Rust
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# Node (nvm is slow to init; loaded on demand would be faster, but this is simple)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# Windsurf
[ -d "$HOME/.codeium/windsurf/bin" ] && export PATH="$HOME/.codeium/windsurf/bin:$PATH"

# Nicer ls colors on BSD/mac (https://geoff.greer.fm/lscolors/)
export CLICOLOR=1
export LSCOLORS="gefxcxdxbxegedabagacad"

# Carried over from old zshrc; hides all cargo warnings globally, so opt in
# by uncommenting if you still want it.
# export RUSTFLAGS=-Awarnings
