# source default bash profile
source "$HOME/.profile"

# shell theme
# https://github.com/base16-project/base16-shell.git
export BASE16_THEME_DEFAULT=onedark
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && [ -s "$BASE16_SHELL/profile_helper.sh" ] && source "$BASE16_SHELL/profile_helper.sh"

# bat theme
export BAT_THEME=base16-256

# asdf init and config
[ -d "/opt/asdf-vm" ] && . /opt/asdf-vm/asdf.sh
command -v direnv > /dev/null && eval "$(direnv hook zsh)"
