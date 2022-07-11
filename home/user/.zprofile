# editor
export EDITOR=vim

# Change pager to LESS (for psql, etc)
export PAGER="less -S"

# ~/.local/bin
[ -d "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin:$PATH"

# asdf init and config
[ -d "/opt/asdf-vm" ] && . /opt/asdf-vm/asdf.sh
command -v direnv > /dev/null && eval "$(direnv hook zsh)"
