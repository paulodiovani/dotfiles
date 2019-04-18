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

# automatically choose node version
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# direnv
command -v direnv > /dev/null && eval "$(direnv hook zsh)"
