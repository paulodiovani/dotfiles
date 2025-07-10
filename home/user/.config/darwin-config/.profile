#! /bin/env sh
#
# macOS specific .profile

# autojump config (Mac OSX)
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

# homebrew config
[ -d "/opt/homebrew" ] && eval "$(/opt/homebrew/bin/brew shellenv)"
export HOMEBREW_NO_AUTO_UPDATE=1

# postgresql libs
[ -d "/opt/homebrew/opt/libpq/bin" ] && export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# llvm and clang
# if [ -d "/opt/homebrew/opt/llvm" ]; then
#   export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
#   export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
#   export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
# fi

# default user for macos
export DEFAULT_USER=paulodiovani
