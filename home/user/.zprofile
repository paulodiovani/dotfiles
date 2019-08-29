# editor
export EDITOR=vim

#~/bin
[ -d "$HOME/bin" ] && export PATH="$HOME/bin:$PATH"

# rbenv init
export RBENV_DIR="$HOME/.rbenv"
[ ! -d "$RBENV_DIR" ] && mkdir -p "$RBENV_DIR"
[ -s "$RBENV_DIR/bin/rbenv" ] && export PATH="$RBENV_DIR/bin:$PATH"
command -v rbenv > /dev/null && eval "$(rbenv init -)"

# nvm init
[ -z "$NVM_DIR" ] && export NVM_DIR="$HOME/.nvm"
[ -s /usr/share/nvm/nvm.sh ] && source /usr/share/nvm/nvm.sh
# source /usr/share/nvm/bash_completion
# source /usr/share/nvm/install-nvm-exec
command -v nvm > /dev/null && source .zprofile-load-nvmrcsss

# direnv
command -v direnv > /dev/null && eval "$(direnv hook zsh)"
