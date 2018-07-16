# shell icon for zsh theme
icon_list=(☕ 👽 👾 🤖 🦑 🍄 🥑 🎃 🤔 💩)
SHELL_ICON=${icon_list[$RANDOM % ${#icon_list[@]} + 1]}

#~/bin
[ -d "$HOME/bin" ] && export PATH="$HOME/bin:$PATH"

# rbenv init
export RBENV_DIR="$HOME/.rbenv"
[ ! -d "$RBENV_DIR" ] && mkdir -p "$RBENV_DIR"
[ -s "$RBENV_DIR/bin/rbenv" ] && export PATH="$RBENV_DIR/bin:$PATH"
command -v rbenv > /dev/null && eval "$(rbenv init -)"

# nodenv init
# export NODENV_DIR="$HOME/.nodenv"
# [ ! -d "$NODENV_DIR" ] && mkdir -p "$NODENV_DIR"
# [ -s "$NODENV_DIR/bin/nodenv" ] && export PATH="$NODENV_DIR/bin:$PATH"
# command -v nodenv > /dev/null && eval "$(nodenv init -)"

# nvm init
[ -z "$NVM_DIR" ] && export NVM_DIR="$HOME/.nvm"
[ -s /usr/share/nvm/nvm.sh ] && source /usr/share/nvm/nvm.sh
# source /usr/share/nvm/bash_completion
# source /usr/share/nvm/install-nvm-exec

# direnv
command -v direnv > /dev/null && eval "$(direnv hook zsh)"
