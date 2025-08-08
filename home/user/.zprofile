# source default bash profile
source "$HOME/.profile"

# load tinted-shell theme
export TINTED_SHELL_ENABLE_BASE16_VARS=1
export TINTED_SHELL_ENABLE_BASE24_VARS=1

# load tinted-theme using tinty
if command -v tinty > /dev/null; then
  tinty init
fi
