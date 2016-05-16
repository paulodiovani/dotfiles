# ~/bin
[ -d "$HOME/bin" ] && export PATH="$HOME/bin:$PATH"

# rbenv init
export RBENV_DIR="$HOME/.rbenv"
[ -s "$RBENV_DIR/bin/rbenv" ] && export PATH="$HOME/.rbenv/bin:$PATH"
command -v rbenv > /dev/null && eval "$(rbenv init -)"

# ndenv init
export NDENV_DIR="$HOME/.ndenv"
[ -s "$NDENV_DIR/bin/ndenv" ] && export PATH="$HOME/.ndenv/bin:$PATH"
command -v ndenv > /dev/null && eval "$(ndenv init -)"

