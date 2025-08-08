# Some more alias to avoid making mistakes:
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Use cd -P to expand symlinks to full paths
alias cdp='cd -P'

# scrollable less and tabwidth=4
alias less='less -S -x4'
alias expand='expand -t4'

# vim less (user nvim as less for syntax highlight)
alias vimless='/usr/share/nvim/runtime/macros/less.sh'

# search files with preview
alias files='fzf -m --preview="bat --style=numbers --color=always {}"'

# aliases for common commands
alias bx='bundle exec'
alias dc='docker compose'

# list and select a tinted-theme
alias tinted-theme-select='tinty apply $(tinty list | fzf)'

# make aliases work with sudo and noglob
alias sudo='sudo '
alias noglob='noglob '

# make linux more polite
alias please='sudo'

# use github copilot for command suggestions
copilot() { gh copilot suggest --target shell "\"$@\"" }

# switch aws profiles from ~/.aws/credentials
alias aws-switch-profile="aws configure list-profiles | fzf | xargs -I{} echo export AWS_PROFILE={} | source /dev/stdin"

# git command overrides
git() {
  if [[ $@ =~ 'push -f' || $@ =~ 'push --force' ]]; then
    command git push --force-with-lease
  elif [[ $1 == 'diff' ]]; then
    cmd=$1
    shift
    command git "${cmd}vim" $@
  else
    command git "$@"
  fi
}

gradle() {
  if [ -f ./gradlew ]; then
    ./gradlew "$@"
  else
    command gradle "$@"
  fi
}

# os-specific aliases
[ -f "$HOME/.config/os-config/.bash_aliases" ] && . "$HOME/.config/os-config/.bash_aliases"
