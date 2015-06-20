# Rbenv init
export RBENV_DIR="$HOME/.rbenv"
[ -s "$RBENV_DIR/bin/rbenv" ] && export PATH="$HOME/.rbenv/bin:$PATH"
[ -s "$RBENV_DIR/bin/rbenv" ] && eval "$(rbenv init -)"

# NVM init
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

