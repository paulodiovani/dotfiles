# shell theme
# https://github.com/chriskempson/base16-shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && [ -s "$BASE16_SHELL/profile_helper.sh" ] && source "$BASE16_SHELL/profile_helper.sh"

# onedark theme
base16_onedark

# editor
export EDITOR=vim

# Change pager to LESS (for psql, etc)
export PAGER="less -S"

# Enable wayland support for firefox
[ "$XDG_SESSION_TYPE" = "wayland" ] && export MOZ_ENABLE_WAYLAND=1

# ~/.local/bin
[ -d "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin:$PATH"

# asdf init and config
[ -d "/opt/asdf-vm" ] && . /opt/asdf-vm/asdf.sh
command -v direnv > /dev/null && eval "$(direnv hook zsh)"
