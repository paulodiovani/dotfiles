#! /bin/env sh

# editor
export EDITOR=vim

# Change pager to LESS (for psql, etc)
export PAGER="less -S"

# Fuzzy search command and options
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS} --no-mouse --bind='F12:toggle-preview'"

# ~/.local/bin
[ -d "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin:$PATH"
