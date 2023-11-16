#! /bin/env sh

# editor
export EDITOR=vim

# Change pager to LESS (for psql, etc)
export PAGER="less -S"

# Fuzzy search command and options
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS} --no-mouse --bind='F12:toggle-preview'"

# Change NPM PREFIX
export NPM_CONFIG_PREFIX=~/.local

# Change PNPM HOME
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# autojump config (Mac OSX)
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

# ~/.local/bin
[ -d "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin:$PATH"
