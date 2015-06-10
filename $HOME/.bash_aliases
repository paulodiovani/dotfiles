# Some more alias to avoid making mistakes:
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# scrollable less
alias less='less -S'

# vim less (user vim as less for syntax highlight)
alias vimless='/usr/share/vim/vim74/macros/less.sh'

# force some apps to use adwaita theme
alias firefox='env GTK2_RC_FILES=/usr/share/themes/Adwaita/gtk-2.0/gtkrc firefox'
alias spotify='env GTK2_RC_FILES=/usr/share/themes/Adwaita/gtk-2.0/gtkrc spotify'

# alias for bundler commands
alias bx='bundle exec'
