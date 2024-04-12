# source default bash profile
source "$HOME/.profile"

# Base16 Shell
# https://github.com/tinted-theming/base16-shell
export BASE16_THEME_DEFAULT=onedark
BASE16_SHELL_PATH="$HOME/.config/base16-shell"
[ -n "$PS1" ] && \
  [ -s "$BASE16_SHELL_PATH/profile_helper.sh" ] && \
    source "$BASE16_SHELL_PATH/profile_helper.sh"

export BASE16_FZF_PATH=$HOME/.config/base16-fzf

# bat theme
export BAT_THEME=base16-256
